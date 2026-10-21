#!/usr/bin/env bash
# Install ShipKit without a registry: build the kit from this source tree (or use a GitHub Release bundle), install the
# kernel and template tarballs into a local toolchain, render the project, and leave a ./shipkit launcher.
#
#   bash shipkit/install.sh <target-dir> [--existing] [--set name=value]...
#
# Nothing is published to or fetched from the npm registry for ShipKit's own packages: the tarballs are local. The
# installer uses the npm CLI that ships with Node for those local tarballs (pnpm refuses a local set whose members
# declare each other by exact version); the rendered project itself runs on pnpm.
set -euo pipefail

HERE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
TARGET=""
EXISTING=0
SETS=()

usage() {
  sed -n '2,7p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}
die() { echo "shipkit install: $*" >&2; exit 1; }

while [ $# -gt 0 ]; do
  case "$1" in
    --existing) EXISTING=1; shift ;;
    --set) [ $# -ge 2 ] || die "--set needs name=value"; SETS+=("$2"); shift 2 ;;
    -h|--help) usage; exit 0 ;;
    --*) die "unknown option $1" ;;
    *) [ -z "$TARGET" ] || die "one target directory only"; TARGET=$1; shift ;;
  esac
done
[ -n "$TARGET" ] || { usage; exit 2; }
command -v node >/dev/null 2>&1 || die "node is required"
command -v npm >/dev/null 2>&1 || die "npm is required (it ships with Node; no registry account is used)"

# The bundle is either a release directory (kernel/ and template/ sit beside this script) or the source tree.
SOURCE=$HERE
BUILT=""
if [ ! -d "$SOURCE/kernel" ] || ! ls "$SOURCE"/kernel/*.tgz >/dev/null 2>&1; then
  REPO=$(cd -- "$HERE/.." && pwd)
  [ -f "$REPO/pnpm-workspace.yaml" ] || die "run this from the ShipKit repository or a release bundle"
  command -v pnpm >/dev/null 2>&1 || die "pnpm is required to build the kit from source"
  SOURCE=$(mktemp -d)
  BUILT=$SOURCE
  trap 'rm -rf "$BUILT"' EXIT
  echo "install: building the kit from $REPO"
  bash "$REPO/shipkit/release.sh" --out "$SOURCE" >/dev/null
fi

VERSION=$(cat "$SOURCE/VERSION")
HOME_DIR=${SHIPKIT_HOME:-$HOME/.local/share/shipkit}
KIT="$HOME_DIR/kit"
rm -rf "$KIT"
mkdir -p "$KIT"
printf '{"name":"shipkit-toolchain","private":true,"type":"module"}\n' > "$KIT/package.json"
echo "install: installing shipkit $VERSION into $KIT (local tarballs only)"
(
  cd "$KIT"
  npm_config_cache="${SHIPKIT_NPM_CACHE:-$HOME_DIR/.npm}" npm install --no-audit --no-fund --loglevel=error --package-lock=false \
    "$SOURCE"/kernel/*.tgz "$SOURCE"/template/*.tgz >/dev/null
)

mkdir -p "$TARGET"
if [ "$EXISTING" -eq 0 ]; then
  [ -z "$(ls -A "$TARGET")" ] || die "$TARGET is not empty; pass --existing to install into an existing project"
  # `init` resolves the installed template through <cwd>/package.json, so the empty target needs one first; the
  # rendered scaffold replaces it.
  printf '{"name":"%s","private":true}\n' "$(basename "$TARGET")" > "$TARGET/package.json"
  set_args=()
  for value in ${SETS[@]+"${SETS[@]}"}; do set_args+=(--set "$value"); done
  ( cd "$TARGET" && node "$KIT/node_modules/@shipkit/cli/dist/main.js" \
      init --template "$KIT/node_modules/shipkit-tpl-mono-repo-std" --out . ${set_args[@]+"${set_args[@]}"} )
else
  echo "install: existing project; the kit is installed but init was not run"
fi

cat > "$TARGET/shipkit" <<'LAUNCH'
#!/usr/bin/env bash
# The ShipKit launcher written by shipkit/install.sh: the installed CLI, run against this project.
set -euo pipefail
kit="${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit"
exec node "$kit/node_modules/@shipkit/cli/dist/main.js" "$@"
LAUNCH
chmod +x "$TARGET/shipkit"

cat <<NEXT
install: shipkit $VERSION toolchain at $KIT
install: launcher $TARGET/shipkit
Next:
  cd "$TARGET"
  pnpm install
  ./shipkit doctor
  ./shipkit verify
Template for upgrade: $KIT/node_modules/shipkit-tpl-mono-repo-std
NEXT
