setup() {
  . "${DEVBL64_BUILD}/bashlib64.bash"
}

@test "common globals are set" {

  [[ -n "$BL64_OS_ALIAS_CHOWN_DIR" ]] && \
  [[ -n "$BL64_OS_ALIAS_CP_FILE" ]] && \
  [[ -n "$BL64_OS_ALIAS_ID_USER" ]] && \
  [[ -n "$BL64_OS_ALIAS_LS_FILES" ]] && \
  [[ -n "$BL64_OS_ALIAS_RM_FILE" ]] && \
  [[ -n "$BL64_OS_ALIAS_RM_FULL" ]] && \
  [[ -n "$BL64_OS_ALIAS_SUDO_ENV" ]]

}
