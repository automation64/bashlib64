setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "bl64_os_set_alias: common globals are set" {

  [[ -n "$BL64_OS_ALIAS_CHOWN_DIR" ]] && \
  [[ -n "$BL64_OS_ALIAS_CP_FILE" ]] && \
  [[ -n "$BL64_OS_ALIAS_ID_USER" ]] && \
  [[ -n "$BL64_OS_ALIAS_LS_FILES" ]] && \
  [[ -n "$BL64_OS_ALIAS_MKDIR_FULL" ]] && \
  [[ -n "$BL64_OS_ALIAS_RM_FILE" ]] && \
  [[ -n "$BL64_OS_ALIAS_RM_FULL" ]]

}
