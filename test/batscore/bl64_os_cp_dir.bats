setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_os_cp_dir: copy dir" {
  set +u # to avoid IFS missing error in run function
  source="${TEST_SANDBOX}/source"
  dest="${TEST_SANDBOX}/dest"
  mkdir "$source" &&
  mkdir "$dest" &&
  ls /etc > "$source/file"
  run bl64_os_cp_dir "$source" "$dest"
  assert_equal "$status" '0'
  assert_dir_exist "${dest}/source"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
