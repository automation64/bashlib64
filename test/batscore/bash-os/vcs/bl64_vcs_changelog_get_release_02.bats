setup() {
  export sample="$TESTMANSH_TEST_SAMPLES/changelog_01/CHANGELOG.md"
}

@test "bl64_vcs_changelog_get_release: tag not found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_changelog_get_release "$sample" "XXX"
  assert_failure
}

@test "bl64_vcs_changelog_get_release: tag found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_changelog_get_release "$sample" "20.0.0"
  assert_success
}
