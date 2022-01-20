setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_os_set_alias: common globals are set" {

  [[ -n "$BL64_OS_ALIAS_CHOWN_DIR" ]] && \
  [[ -n "$BL64_OS_ALIAS_CP_FILE" ]] && \
  [[ -n "$BL64_OS_ALIAS_ID_USER" ]] && \
  [[ -n "$BL64_OS_ALIAS_LS_FILES" ]] && \
  [[ -n "$BL64_OS_ALIAS_MKDIR_FULL" ]] && \
  [[ -n "$BL64_OS_ALIAS_MV" ]] && \
  [[ -n "$BL64_OS_ALIAS_RM_FILE" ]] && \
  [[ -n "$BL64_OS_ALIAS_RM_FULL" ]]

}
