setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_core_env: defaults are set" {
  [[ -n "$BL64_LIB_DEBUG" ]] && \
  [[ -n "$BL64_LIB_STRICT" ]] && \
  [[ -n "$BL64_LIB_LANG" ]] && \
  [[ -n "$BL64_LIB_SIGNAL_HUP" ]] && \
  [[ -n "$BL64_LIB_SIGNAL_STOP" ]] && \
  [[ -n "$BL64_LIB_SIGNAL_QUIT" ]] && \
  [[ -n "$BL64_SCRIPT_NAME" ]] && \
  [[ -n "$BL64_SCRIPT_SID" ]]
}

@test "bl64_core_env: public constants are set" {
  assert_equal "$BL64_LIB_VAR_NULL" '__s64__' && \
  assert_equal "$BL64_LIB_VAR_TBD" 'TBD'
}
