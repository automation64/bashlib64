setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_vcs_env: public constants are set" {
  assert_equal "$BL64_XSV_FS" '_@64@_'
  assert_equal "$BL64_XSV_FS_SPACE" ' '
  assert_equal "$BL64_XSV_FS_TAB" '	'
  assert_equal "$BL64_XSV_FS_COLON" ':'
  assert_equal "$BL64_XSV_FS_SEMICOLON" ';'
  assert_equal "$BL64_XSV_FS_COMMA" ','
  assert_equal "$BL64_XSV_FS_PIPE" '|'
  assert_equal "$BL64_XSV_FS_AT" '@'
  assert_equal "$BL64_XSV_FS_DOLLAR" '$'
  assert_equal "$BL64_XSV_FS_SLASH" '/'
}
