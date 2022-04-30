setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_xsv_dump_destination="$(temp_make)"
}

teardown() {

  temp_del "$_bl64_xsv_dump_destination"

}

@test "bl64_xsv_dump: dump csv file" {

  expected="$(<${DEVBL_SAMPLES}/csv_02.txt)"

  run bl64_xsv_dump "${DEVBL_SAMPLES}/csv_01.txt"
  assert_success
  assert_output "$expected"

}
