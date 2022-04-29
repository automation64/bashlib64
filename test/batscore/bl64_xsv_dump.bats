setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_xsv_dump_destination="$(mktemp -d)"
  export _bl64_xsv_dump_destination
}

teardown() {

  [[ -d "$_bl64_xsv_dump_destination" ]] && rm -Rf "$_bl64_xsv_dump_destination"

}

@test "bl64_xsv_dump: parameter is not present" {

  run bl64_xsv_dump
  assert_failure

}

@test "bl64_xsv_dump: dump csv file" {

  expected="$(<${DEVBL_SAMPLES}/csv_02.txt)"

  run bl64_xsv_dump "${DEVBL_SAMPLES}/csv_01.txt"
  assert_success
  assert_output "$expected"

}
