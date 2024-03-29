@test "bl64_iam_group_add: root privilege" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
  run bl64_iam_group_add testgrp
  assert_failure
}
