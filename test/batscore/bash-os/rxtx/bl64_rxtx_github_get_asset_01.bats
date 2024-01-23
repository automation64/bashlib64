@test "bl64_rxtx_github_get_asset: function parameter missing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rxtx_github_get_asset
  assert_failure
}

@test "bl64_rxtx_github_get_asset: 2 function parameter missing" {
  run bl64_rxtx_github_get_asset 'ownerx'
  assert_failure
}

@test "bl64_rxtx_github_get_asset: 3 function parameter missing" {
  run bl64_rxtx_github_get_asset 'ownerx' 'repox'
  assert_failure
}

@test "bl64_rxtx_github_get_asset: 4 function parameter missing" {
  run bl64_rxtx_github_get_asset 'ownerx' 'repox' 'tagxxx'
  assert_failure
}

@test "bl64_rxtx_github_get_asset: 5 function parameter missing" {
  run bl64_rxtx_github_get_asset 'ownerx' 'repox' 'tagxxx' '/dev/null'
  assert_failure
}
