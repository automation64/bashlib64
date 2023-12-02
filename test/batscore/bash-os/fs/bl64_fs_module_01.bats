setup() {
  export DEV_TEST_VALUE_LIBRARY_MODE='MODULAR'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function test_load_module(){
  . "${DEV_TEST_PATH_LIBRARY}/bashlib64-module-fs.bash"
}

@test "bl64_fs_module: module load" {
  run test_load_module
  assert_success
}
