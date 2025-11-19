@test "bl64_vcs_changelog_get_release: version found - first" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  test_version='3.39.1'
  sample="$TESTMANSH_TEST_SAMPLES/changelog_02/CHANGELOG.md"
  expected="${TESTMANSH_TEST_SAMPLES}/changelog_02/output-${test_version}"
  run bl64_vcs_changelog_get_release "$sample" "$test_version"
  assert_success
  assert_output "$(<${expected})"
}
