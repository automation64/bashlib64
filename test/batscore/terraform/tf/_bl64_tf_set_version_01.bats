setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  terraform_test_bin='/usr/local/bin/terraform'
  [[ -x "$terraform_test_bin" ]] || skip 'terraform cli not found'
}

@test "_bl64_tf_set_version: run ok" {
  export BL64_TF_CMD_TERRAFORM="$terraform_test_bin"
  run _bl64_tf_set_version
  assert_success
}
