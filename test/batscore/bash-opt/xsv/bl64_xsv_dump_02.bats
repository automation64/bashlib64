setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_xsv_dump_destination="$(temp_make)"
}

teardown() {

  temp_del "$_bl64_xsv_dump_destination"

}

@test "bl64_xsv_dump: dump csv file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  expected="$(<${TESTMANSH_TEST_SAMPLES}/csv_02.txt)"

  run bl64_xsv_dump "${TESTMANSH_TEST_SAMPLES}/csv_01.txt"
  assert_success
  assert_output "$expected"

}
