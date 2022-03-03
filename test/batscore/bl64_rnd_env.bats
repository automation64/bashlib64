setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_env: public constants are set" {

  assert_equal "$BL64_RND_LENGTH_1" 1
  assert_equal "$BL64_RND_LENGTH_20" 20
  assert_equal "$BL64_RND_LENGTH_100" 100
  assert_equal "$BL64_RND_RANDOM_MIN" 0
  assert_equal "$BL64_RND_RANDOM_MAX" 32767

  assert_equal "$BL64_RND_POOL_UPPERCASE" "$(printf '%b' $(printf '\\%o' {65..90}))"
  assert_equal "$BL64_RND_POOL_LOWERCASE" "$(printf '%b' $(printf '\\%o' {97..122}))"
  assert_equal "$BL64_RND_POOL_DIGITS" "$(printf '%b' $(printf '\\%o' {48..57}))"
  assert_equal "$BL64_RND_POOL_ALPHANUMERIC" "${BL64_RND_POOL_UPPERCASE}${BL64_RND_POOL_LOWERCASE}${BL64_RND_POOL_DIGITS}"

  assert_equal "$BL64_RND_ERROR_MIN" 1
  assert_equal "$BL64_RND_ERROR_MAX" 2

}