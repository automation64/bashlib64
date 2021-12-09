setup() {
  SHELL64_LIB_STRICT='0'
  SHELL64_LIB="${PROJECT_SHELL64_SRC}"
  . "${SHELL64_LIB}/shell64.bash"

  PROJECT_SHELL64_TEST___TMP="$(mktemp -d)"
  touch "$PROJECT_SHELL64_TEST___TMP/file1"
  touch "$PROJECT_SHELL64_TEST___TMP/file2"
  touch "$PROJECT_SHELL64_TEST___TMP/file3"
}

function teardown() {
  [[ -d "$$PROJECT_SHELL64_TEST___TMP" ]] && \
  rm -Rf $PROJECT_SHELL64_TEST___TMP
  :
}

@test "1: common globals are set" {

[[ -n "$SHELL64_OS_ALIAS_CHOWN_DIR" ]] && \
[[ -n "$SHELL64_OS_ALIAS_CP_FILE" ]] && \
[[ -n "$SHELL64_OS_ALIAS_ID_USER" ]] && \
[[ -n "$SHELL64_OS_ALIAS_LS_FILES" ]] && \
[[ -n "$SHELL64_OS_ALIAS_SUDO_ENV" ]]

}
