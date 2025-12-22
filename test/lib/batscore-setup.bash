#
# Test / Setup batscore environment
#
# * File automatically loaded by testmansh
#

#
# Imports
#

# Import batscore modules
. "$TESTMANSH_CMD_BATS_HELPER_SUPPORT" &&
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT" &&
  . "$TESTMANSH_CMD_BATS_HELPER_FILE" &&
  . "${TESTMANSH_TEST_LIB}/test.env" ||
  { echo 'test:Error: unable to load test environment' 2>&1 && exit 1; }

#
# Globals
#

# Base path for the testing libraries
export DEV_TEST_PATH_LIBRARY="${TESTMANSH_PROJECT_BUILD}/prepare/project"
export DEV_TEST_BASHLIB64="${DEV_TEST_PATH_LIBRARY}/bashlib64.bash"

# Setup initialization only?. Empty: No, Not-Empty: Yes
export DEV_TEST_INIT_ONLY="${DEV_TEST_INIT_ONLY:-}"

#
# Main
#

if [[ -z "$DEV_TEST_INIT_ONLY" ]]; then

  # Do not overwrite signals already set by bats-core
  export BL64_LIB_TRAPS='0'

  # Disable compatibility mode to allow strict version checking
  export BL64_LIB_COMPATIBILITY='OFF'

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
fi
:
