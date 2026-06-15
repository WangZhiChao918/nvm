#!/bin/bash

# Interactive test script to demonstrate bash_completion enhancements
# Run this from the project root: bash test_completion_demo.sh

export NVM_DIR="$(pwd)"

# Source nvm and bash_completion
. ./nvm.sh
. ./bash_completion

# Setup test environment
echo "Setting up test environment..."
mkdir -p "${NVM_DIR}/alias/lts"
echo "v18.17.0" > "${NVM_DIR}/alias/lts/hydrogen"
echo "v20.5.0" > "${NVM_DIR}/alias/lts/iron"
echo "v16.20.0" > "${NVM_DIR}/alias/lts/gallium"
echo "v18.0.0" > "${NVM_DIR}/alias/my-node"
echo "v20.0.0" > "${NVM_DIR}/alias/default"

echo "Test environment ready!"
echo ""

# Helper function to demonstrate completion
demo_completion() {
  local description="$1"
  shift
  COMP_WORDS=("$@")
  COMP_CWORD=$((${#COMP_WORDS[@]} - 1))
  __nvm

  echo "Test: $description"
  echo "Command: ${COMP_WORDS[*]}"
  echo "Completions: ${COMPREPLY[*]}"
  echo ""
}

echo "=== Bash Completion Demo ==="
echo ""

demo_completion "Basic command completion" "nvm" ""
demo_completion "nvm use --lts= completion" "nvm" "use" "--lts="
demo_completion "nvm install --lts= completion" "nvm" "install" "--lts="
demo_completion "Partial LTS completion (--lts=hy)" "nvm" "use" "--lts=hy"
demo_completion "nvm use --lts (space) completion" "nvm" "use" "--lts" ""
demo_completion "Custom alias completion" "nvm" "alias" ""
demo_completion "Option completion for install" "nvm" "install" "-"
demo_completion "Option completion for use" "nvm" "use" "-"

echo "=== Demo Complete ==="
echo ""
echo "To test interactively, run:"
echo "  source ./bash_completion"
echo "  nvm use --lts=<TAB><TAB>"
