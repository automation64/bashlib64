setup() {
  export sample="$TESTMANSH_TEST_SAMPLES/changelog_01/CHANGELOG.md"
}

@test "bl64_vcs_changelog_get_release: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_changelog_get_release
  assert_failure
}

@test "bl64_vcs_changelog_get_release: file is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_changelog_get_release '/fate/change/log/xxx'
  assert_failure
}

@test "bl64_vcs_changelog_get_release: tag is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_changelog_get_release "$sample"
  assert_failure
}
