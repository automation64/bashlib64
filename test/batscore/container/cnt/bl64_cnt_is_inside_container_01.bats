setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -n "$container" ]] || skip 'requires container mode'
}

@test "bl64_cnt_is_inside_container: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cnt_is_inside_container
  assert_success
}
