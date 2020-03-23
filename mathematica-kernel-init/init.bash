SCRIPT_DIR="$(cd "$( dirname "$0" )" && pwd)"

mkdir -p                  "$HOME/Library/Wolfram Research/Plugin/Licensing"
cp "$SCRIPT_DIR/mathpass" "$HOME/Library/Wolfram Research/Plugin/Licensing"

mkdir -p                  "$HOME/Library/Mathematica/Kernel"
cp "$SCRIPT_DIR/init.m"   "$HOME/Library/Mathematica/Kernel/init.m"
