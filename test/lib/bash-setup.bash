#
# Test / Setup bash environment
#

. bin/dev-set &&
  . bin/dev-env-project &&
  . "${DEV_PATH_TEST}/lib/test.env" &&
  . "${DEV_BUILD_PROJECT_PATH_TARGET}/bashlib64.bash" ||
  { echo 'test:Error: unable to load test environment' 2>&1 && exit 1; }
