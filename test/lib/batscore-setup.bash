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

# Use 6 to enable bashlib64 function debug. WARNING: tests that rely pre-recorded output fill fail due to extra debug info
export BL64_LIB_DEBUG=0

# Test-case specific variables
export DEVBL_TEST_BASHLIB64="${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"
