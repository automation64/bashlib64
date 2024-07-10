#
# Test / Setup bash environment
#
# * File automatically loaded by ad-hoc
#

#
# Imports
#

. bin/dev-set &&
  . "${DEV_PATH_TEST}/lib/test.env" &&
  . "${DEV_PATH_BUILD_PREPARE}/bashlib64.bash" ||
  { echo 'test:Error: unable to load test environment' 2>&1 && exit 1; }

#
# Globals
#

# Emulate testmansh env to easily port batscore tests
export TESTMANSH_PROJECT_LIB="$DEV_PATH_LIB"
export TESTMANSH_PROJECT_BUILD="$DEV_PATH_BUILD"
export TESTMANSH_TEST="$DEV_PATH_TEST"
export TESTMANSH_TEST_SAMPLES="${DEV_PATH_TEST}/samples"
export TESTMANSH_TEST_LIB="${DEV_PATH_TEST}/lib"
