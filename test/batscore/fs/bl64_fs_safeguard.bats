setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_fs_safeguard_destination="$(mktemp -d)"
  export _bl64_fs_safeguard_destination
}

teardown() {

  [[ -d "$_bl64_fs_safeguard_destination" ]] && rm -Rf "$_bl64_fs_safeguard_destination"

}

@test "bl64_fs_safeguard: backup" {

  test_file="${_bl64_fs_safeguard_destination}/org"
  cat "${DEVBL_SAMPLES}/text_01.txt" > "$test_file"

  run bl64_fs_safeguard "$test_file"
  assert_success

  assert_not_exists "$test_file"
  assert_exists "${test_file}${BL64_FS_SAFEGUARD_POSTFIX}"

}
