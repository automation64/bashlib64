@test "bl64_rnd_env: public constants are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_equal "$BL64_RND_LENGTH_1" 1
  assert_equal "$BL64_RND_LENGTH_20" 20
  assert_equal "$BL64_RND_LENGTH_100" 100
  assert_equal "$BL64_RND_RANDOM_MIN" 0
  assert_equal "$BL64_RND_RANDOM_MAX" 32767

  test_BL64_RND_POOL_UPPERCASE="$(printf '%b' $(printf '\\%o' {65..90}))"
  test_BL64_RND_POOL_LOWERCASE="$(printf '%b' $(printf '\\%o' {97..122}))"
  test_BL64_RND_POOL_DIGITS="$(printf '%b' $(printf '\\%o' {48..57}))"

  assert_equal "$BL64_RND_POOL_UPPERCASE" "$test_BL64_RND_POOL_UPPERCASE"
  assert_equal "$BL64_RND_POOL_LOWERCASE" "$test_BL64_RND_POOL_LOWERCASE"
  assert_equal "$BL64_RND_POOL_DIGITS" "$test_BL64_RND_POOL_DIGITS"
  assert_equal "$BL64_RND_POOL_ALPHANUMERIC" "${BL64_RND_POOL_UPPERCASE}${BL64_RND_POOL_LOWERCASE}${BL64_RND_POOL_DIGITS}"

}

@test "bl64_rnd_env: BL64_RND_POOL_UPPERCASE content" {

  max=$(( ${#BL64_RND_POOL_UPPERCASE} - 1 ))
  assert_equal "$BL64_RND_POOL_UPPERCASE_MAX_IDX" "$max"
  assert_equal "${BL64_RND_POOL_UPPERCASE:0:1}" 'A'
  assert_equal "${BL64_RND_POOL_UPPERCASE:1:1}" 'B'
  assert_equal "${BL64_RND_POOL_UPPERCASE:${max}:1}" 'Z'

}

@test "bl64_rnd_env: BL64_RND_POOL_LOWERCASE content" {

  max=$(( ${#BL64_RND_POOL_LOWERCASE} - 1 ))
  assert_equal "$BL64_RND_POOL_LOWERCASE_MAX_IDX" "$max"
  assert_equal "${BL64_RND_POOL_LOWERCASE:0:1}" 'a'
  assert_equal "${BL64_RND_POOL_LOWERCASE:1:1}" 'b'
  assert_equal "${BL64_RND_POOL_LOWERCASE:${max}:1}" 'z'

}

@test "bl64_rnd_env: BL64_RND_POOL_DIGITS content" {

  max=$(( ${#BL64_RND_POOL_DIGITS} - 1 ))
  assert_equal "$BL64_RND_POOL_DIGITS_MAX_IDX" "$max"
  assert_equal "${BL64_RND_POOL_DIGITS:0:1}" '0'
  assert_equal "${BL64_RND_POOL_DIGITS:1:1}" '1'
  assert_equal "${BL64_RND_POOL_DIGITS:${max}:1}" '9'

}

@test "bl64_rnd_env: BL64_RND_POOL_ALPHANUMERIC content" {

  max=$(( ${#BL64_RND_POOL_ALPHANUMERIC} - 1 ))
  umax=$(( ${#BL64_RND_POOL_UPPERCASE} - 1 ))
  lmax=$(( ${#BL64_RND_POOL_LOWERCASE} - 1 + umax + 1 ))
  assert_equal "$BL64_RND_POOL_ALPHANUMERIC_MAX_IDX" "$max"
  assert_equal "${BL64_RND_POOL_ALPHANUMERIC:0:1}" 'A'
  assert_equal "${BL64_RND_POOL_ALPHANUMERIC:1:1}" 'B'
  assert_equal "${BL64_RND_POOL_ALPHANUMERIC:${umax}:1}" 'Z'
  assert_equal "${BL64_RND_POOL_ALPHANUMERIC:${lmax}:1}" 'z'
  assert_equal "${BL64_RND_POOL_ALPHANUMERIC:${max}:1}" '9'

}
