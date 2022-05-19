#
# Initialize bats-core test
#
# * Source this file from the first line of the setup() function in the test-case
#

. "${DEVBL_BATS_HELPER_SUPPORT}/load.bash"
. "${DEVBL_BATS_HELPER_ASSERT}/load.bash"
. "${DEVBL_BATS_HELPER_FILE}/load.bash"

# Do not overwrite signals already set by bats-core
export BL64_LIB_TRAPS='0'
. "$DEVBL_TEST_BASHLIB64"

# Sets used by bats-core. Do not overwrite
set -o 'errexit'
set +o 'nounset'

# Do not set/unset: 'keyword', 'noexec'

# Use 6 to enable bashlib64 function debug
export BL64_LIB_DEBUG=0
