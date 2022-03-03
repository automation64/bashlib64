setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

# @test "bl64_rnd_get_range: check range" {

#   test="$(bl64_rnd_get_range 2 8)"
#   assert_equal "$test" "$output"

# }

# @test "bl64_rnd_get_range: dir/" {

#   output='/full/path/to'
#   input='/full/path/to/'
#   test="$(bl64_rnd_get_range "$input")"
#   assert_equal "$test" "$output"

# }
