setup() {
  [[ -f '/run/.containerenv' ]] && skip 'not applicable to container mode'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_cnt_setup: module setup" {
  run bl64_cnt_setup
  assert_success
}
