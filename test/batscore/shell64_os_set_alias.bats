setup() {
  BL64_LIB_STRICT='0'
  BL64_LIB="${PROJECT_BL64_SRC}"
  . "${BL64_LIB}/bashlib64.bash"

  PROJECT_BL64_TEST___TMP="$(mktemp -d)"
  touch "$PROJECT_BL64_TEST___TMP/file1"
  touch "$PROJECT_BL64_TEST___TMP/file2"
  touch "$PROJECT_BL64_TEST___TMP/file3"
}

function teardown() {
  [[ -d "$$PROJECT_BL64_TEST___TMP" ]] && \
  rm -Rf $PROJECT_BL64_TEST___TMP
  :
}

@test "1: common globals are set" {

[[ -n "$BL64_OS_ALIAS_CHOWN_DIR" ]] && \
[[ -n "$BL64_OS_ALIAS_CP_FILE" ]] && \
[[ -n "$BL64_OS_ALIAS_ID_USER" ]] && \
[[ -n "$BL64_OS_ALIAS_LS_FILES" ]] && \
[[ -n "$BL64_OS_ALIAS_SUDO_ENV" ]]

}
