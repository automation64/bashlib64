setup() {
  export DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_source: load library with defaults" {
  run . "${DEV_TEST_PATH_LIBRARY}/bashlib64.bash"
  assert_success
}

@test "bl64_lib_source: load library with BL64_LIB_STRICT=1" {
  export BL64_LIB_STRICT='1'
  run . "${DEV_TEST_PATH_LIBRARY}/bashlib64.bash"
  assert_success
}
