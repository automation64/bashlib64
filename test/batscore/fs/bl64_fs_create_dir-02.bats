setup() {
  . "$DEVBL_TEST_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_create_dir: default mode,owner + 2 dirs" {

  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

  target1="$TEST_SANDBOX/target1"
  target2="$TEST_SANDBOX/target2"

  run bl64_fs_create_dir "$BL64_LIB_DEFAULT" "$BL64_LIB_DEFAULT" "$BL64_LIB_DEFAULT" "$target1" "$target2"
  assert_success
  assert_dir_exist "${target1}"
  assert_dir_exist "${target2}"
}

@test "bl64_fs_create_dir: mode + default owner + 2 dirs" {

  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

  target1="$TEST_SANDBOX/target3"
  target2="$TEST_SANDBOX/target4"

  run bl64_fs_create_dir '0777' "$BL64_LIB_DEFAULT" "$BL64_LIB_DEFAULT" "$target1" "$target2"
  assert_success
  assert_dir_exist "${target1}"
  assert_dir_exist "${target2}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
