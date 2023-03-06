setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  TEST_SANDBOX="$(temp_make)"
  export TEST_SANDBOX
}

teardown() {

  temp_del "$TEST_SANDBOX"

}

@test "bl64_fs_restore: restore + result ok" {

  # Create original file
  original_file_path="${TEST_SANDBOX}/original_file"
  sample="${TESTMANSH_TEST_SAMPLES}/text_01.txt"
  saved_file="${original_file_path}${BL64_FS_SAFEGUARD_POSTFIX}"
  cat "$sample" > "$saved_file"

  # Create updated file
  updated_file="${original_file_path}"
  sample2="${TESTMANSH_TEST_SAMPLES}/text_02.txt"
  cat "$sample2" > "$updated_file"

  run bl64_fs_restore "$original_file_path" '0'
  assert_success

  assert_not_exists "$saved_file"
  assert_exists "$original_file_path"

  run diff "$sample2" "$original_file_path"
  assert_success

}
