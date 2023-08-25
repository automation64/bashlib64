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

# Load the bashlib64 build library for all test-cases
. "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"

# Sets used by bats-core. Do not overwrite
set -o 'errexit'
set +o 'nounset'

# Do not set/unset: 'keyword', 'noexec'

# Test-case specific variables
export DEVBL_TEST_BASHLIB64="${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"

export DEVBL_TEST_VALUE_GIT_OWNER='automation64'
export DEVBL_TEST_VALUE_GIT_RELEASE_REPO='helm64'
export DEVBL_TEST_VALUE_GIT_RELEASE_OWNER='helm64'
export DEVBL_TEST_VALUE_GIT_CLONE_URL="https://github.com/${DEVBL_TEST_VALUE_GIT_OWNER}/bashlib64.git"
export DEVBL_TEST_VALUE_GIT_RAW_URL="https://raw.githubusercontent.com/${DEVBL_TEST_VALUE_GIT_OWNER}/bashlib64/main/bashlib64.bash"
export DEVBL_TEST_VALUE_API_PUBLIC_URL='https://postman-echo.com'

