@test "bl64_xsv_search_records: search one record + found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  search='record1'
  found='bl64_arc_env.bats'

  run bl64_xsv_search_records \
    "$search" \
    "$TESTMANSH_TEST_SAMPLES/csv_01.txt" \
    '4' \
    '1'
  assert_success

  assert_output "$found"

}

@test "bl64_xsv_search_records: search one record + not found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  search='record10'
  found='bl64_arc_env.bats'

  run bl64_xsv_search_records \
    "$search" \
    "$TESTMANSH_TEST_SAMPLES/csv_01.txt" \
    '4' \
    '1'
  assert_success

  assert_output ""

}

@test "bl64_xsv_search_records: search one record + found + 2 output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  search='record1'
  found='bl64_arc_env.bats:file'

  run bl64_xsv_search_records \
    "$search" \
    "$TESTMANSH_TEST_SAMPLES/csv_01.txt" \
    '4' \
    '1:2'
  assert_success

  assert_output "$found"

}

@test "bl64_xsv_search_records: search 2 records + found + 2 output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  search="file${BL64_XSV_FS}record1"
  found='bl64_arc_env.bats:file'

  run bl64_xsv_search_records \
    "$search" \
    "$TESTMANSH_TEST_SAMPLES/csv_01.txt" \
    '2:4' \
    '1:2'
  assert_success

  assert_output "$found"

}
