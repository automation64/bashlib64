setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_xsv_search_records: command parameter is not present" {

  run bl64_xsv_search_records
  assert_equal "$status" $BL64_XSV_ERROR_MISSING_PARAMETER

}

@test "bl64_xsv_search_records: search one record + found" {

  search='record1'
  found='bl64_arc_env.bats'

  run bl64_xsv_search_records \
    "$search" \
    "$DEVBL_SAMPLES/csv_01.txt" \
    '4' \
    '1'
  assert_success

  assert_output "$found"

}

@test "bl64_xsv_search_records: search one record + not found" {

  search='record10'
  found='bl64_arc_env.bats'

  run bl64_xsv_search_records \
    "$search" \
    "$DEVBL_SAMPLES/csv_01.txt" \
    '4' \
    '1'
  assert_success

  assert_output ""

}

@test "bl64_xsv_search_records: search one record + found + 2 output" {

  search='record1'
  found='bl64_arc_env.bats:file'

  run bl64_xsv_search_records \
    "$search" \
    "$DEVBL_SAMPLES/csv_01.txt" \
    '4' \
    '1:2'
  assert_success

  assert_output "$found"

}

@test "bl64_xsv_search_records: search 2 records + found + 2 output" {

  search="file${BL64_XSV_FS}record1"
  found='bl64_arc_env.bats:file'

  run bl64_xsv_search_records \
    "$search" \
    "$DEVBL_SAMPLES/csv_01.txt" \
    '2:4' \
    '1:2'
  assert_success

  assert_output "$found"

}
