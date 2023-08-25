setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_api_call: call executed ok" {
  run bl64_api_call \
    "$DEVBL_TEST_VALUE_API_PUBLIC_URL" \
    '/post' \
    "$BL64_API_METHOD_POST" \
    "$BL64_VAR_NULL" \
    -H "Content-Type: application/json" \
    -d '{"message": "testing"}'
  assert_success
}
