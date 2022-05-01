setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_rnd_get_range: check range" {

  local min=2
  local max=8

  test="$(bl64_rnd_get_range $min $max)"
  (( test <= max && test >= min ))

}
