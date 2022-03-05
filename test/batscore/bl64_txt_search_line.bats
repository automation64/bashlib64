setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_txt_search_line: line is present" {

  line='second line'
  run bl64_txt_search_line "$DEVBL_SAMPLES/text_lines_01.txt" "$line"
  assert_success

}

@test "bl64_txt_search_line: line is not present" {

  line='not present'
  run bl64_txt_search_line "$DEVBL_SAMPLES/text_lines_01.txt" "$line"
  assert_failure

}
