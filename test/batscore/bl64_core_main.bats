setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_core_main: lang is set" {
  assert_equal "$LANG" 'C'
  assert_equal "$LC_ALL" 'C'
  assert_equal "$LANGUAGE" 'C'
}
