@test "bl64_iam_xdg_create: create XDG dirs" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_iam_xdg_create "$HOME"
  assert_success
}
