#
# Initialize bats-core test
#
# * Source this file from the first line of the setup() function in the test-case
#

. "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
. "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
. "$TESTMANSH_CMD_BATS_HELPER_FILE"

# Do not overwrite signals already set by bats-core
export BL64_LIB_TRAPS='0'

# Disable compatibility mode to allow strict version checking
export BL64_LIB_COMPATIBILITY='0'

# Base path for the testing libraries
export DEV_TEST_PATH_LIBRARY="${TESTMANSH_PROJECT_BUILD}/test"

# Load the bashlib64 library for all test-cases
export DEV_TEST_VALUE_LIBRARY_MODE="${DEV_TEST_VALUE_LIBRARY_MODE:-SA}"
case "$DEV_TEST_VALUE_LIBRARY_MODE" in
'SA') . "${DEV_TEST_PATH_LIBRARY}/bashlib64.bash" ;;
'SPLIT') . "${DEV_TEST_PATH_LIBRARY}/bashlib64-core.bash" ;;
'MODULAR') . "${DEV_TEST_PATH_LIBRARY}/bashlib64-module-core.bash" ;;
*)
  echo 'Error: invalid library option'
  exit 1
  ;;
esac

# Sets used by bats-core. Do not overwrite
set -o 'errexit'
set +o 'nounset'

# Do not set/unset: 'keyword', 'noexec'

# Test-case specific variables
export DEV_TEST_BASHLIB64="${DEV_TEST_PATH_LIBRARY}/bashlib64.bash"

export DEV_TEST_VALUE_GIT_OWNER='automation64'
export DEV_TEST_VALUE_GIT_ASSET_REPO='bashlib64'
export DEV_TEST_VALUE_GIT_RELEASE_REPO='cli'
export DEV_TEST_VALUE_GIT_RELEASE_OWNER='cli'
export DEV_TEST_VALUE_GIT_ASSET_FILE='bashlib64-modular.tgz'
export DEV_TEST_VALUE_GIT_CLONE_URL="https://github.com/${DEV_TEST_VALUE_GIT_OWNER}/bashlib64.git"
export DEV_TEST_VALUE_GIT_RAW_URL="https://raw.githubusercontent.com/${DEV_TEST_VALUE_GIT_OWNER}/bashlib64/main/bashlib64.bash"
export DEV_TEST_VALUE_API_PUBLIC_URL='https://httpbin.org'
