@test "bl64_vcs_changelog_get_release: version found - first" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  test_version='20.1.0'
  sample="$TESTMANSH_TEST_SAMPLES/changelog_01/CHANGELOG.md"
  expected="${TESTMANSH_TEST_SAMPLES}/changelog_01/output-${test_version}"
  run bl64_vcs_changelog_get_release "$sample" "$test_version"
  assert_success
  assert_output "$(<${expected})"
}

@test "bl64_vcs_changelog_get_release: version found - last" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  test_version='19.1.0'
  sample="$TESTMANSH_TEST_SAMPLES/changelog_01/CHANGELOG.md"
  expected="${TESTMANSH_TEST_SAMPLES}/changelog_01/output-${test_version}"
  run bl64_vcs_changelog_get_release "$sample" "$test_version"
  assert_success
  assert_output "$(<${expected})"
}

@test "bl64_vcs_changelog_get_release: version found - formatting" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  test_version='19.2.1'
  sample="$TESTMANSH_TEST_SAMPLES/changelog_01/CHANGELOG.md"
  expected="${TESTMANSH_TEST_SAMPLES}/changelog_01/output-${test_version}"
  run bl64_vcs_changelog_get_release "$sample" "$test_version"
  assert_success
  assert_output "$(<${expected})"
}
