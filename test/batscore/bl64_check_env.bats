setup() {
  . "${DEVBL64_BUILD}/bashlib64.bash"
}

@test "internal constants are set" {

  [[ "$_BL64_CHECK_TXT_MISSING_PARAMETER" == 'required parameter is missing' ]] && \
  [[ "$_BL64_CHECK_TXT_COMMAND_NOT_FOUND" == 'the command is not present' ]] && \
  [[ "$_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE" == 'the command is present but has no execution permission' ]] && \
  [[ "$_BL64_CHECK_TXT_FILE_NOT_FOUND" == 'the file is not present' ]] && \
  [[ "$_BL64_CHECK_TXT_FILE_NOT_READABLE" == 'the file is present but has no read permission' ]]

}

@test "exported constants are set" {

  [[ "$BL64_CHECK_ERROR_MISSING_PARAMETER" == 1 ]] && \
  [[ "$BL64_CHECK_ERROR_FILE_NOT_FOUND" == 2 ]] && \
  [[ "$BL64_CHECK_ERROR_FILE_NOT_READ" == 3 ]] && \
  [[ "$BL64_CHECK_ERROR_FILE_NOT_EXECUTE" == 4 ]]

}