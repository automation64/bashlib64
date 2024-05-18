@test "bl64_bsh_profile_path_generate: generate" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_profile_path_generate
  assert_success
}

@test "bl64_bsh_profile_path_generate: generate insecure" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_profile_path_generate ON
  assert_success
}

@test "bl64_bsh_profile_path_generate: generate insecure system" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_profile_path_generate ON ON
  assert_success
}

@test "bl64_bsh_profile_path_generate: generate extra" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_profile_path_generate OFF OFF 'extrapath'
  assert_success
}
