setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "defaults are set" {
  [[ -n "$BL64_LIB_DEBUG" ]] && \
  [[ -n "$BL64_LIB_STRICT" ]] && \
  [[ -n "$BL64_LIB_LANG" ]] && \
  [[ -n "$BL64_LIB_SIGNAL_HUP" ]] && \
  [[ -n "$BL64_LIB_SIGNAL_STOP" ]] && \
  [[ -n "$BL64_LIB_SIGNAL_QUIT" ]] && \
  [[ -n "$BL64_SCRIPT_NAME" ]] && \
  [[ -n "$BL64_SCRIPT_SID" ]]
}

@test "constants are set" {
  [[ "$BL64_LIB_VAR_NULL" == '__s64__' ]] && \
  [[ "$BL64_LIB_VAR_TBD" == 'TBD' ]]
}
