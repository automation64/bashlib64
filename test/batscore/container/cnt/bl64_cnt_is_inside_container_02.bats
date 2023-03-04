setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -n "$container" ]] && skip 'not for container mode'
}

@test "bl64_cnt_is_inside_container: run ok" {
  run bl64_cnt_is_inside_container
  assert_failure
}
