setup() {
  . "${DEVBL64_BUILD}/bashlib64.bash"

  DEVBL64_TEST___TMP="$(mktemp -d)" && \
  touch "$DEVBL64_TEST___TMP/file1" && \
  touch "$DEVBL64_TEST___TMP/file2" && \
  touch "$DEVBL64_TEST___TMP/file3"
}

function teardown() {
  [[ -d "$$DEVBL64_TEST___TMP" ]] && \
  rm -Rf $DEVBL64_TEST___TMP
  :
}

@test "common globals are set" {

[[ -n "$BL64_OS_ALIAS_CHOWN_DIR" ]] && \
[[ -n "$BL64_OS_ALIAS_CP_FILE" ]] && \
[[ -n "$BL64_OS_ALIAS_ID_USER" ]] && \
[[ -n "$BL64_OS_ALIAS_LS_FILES" ]] && \
[[ -n "$BL64_OS_ALIAS_SUDO_ENV" ]]

}
