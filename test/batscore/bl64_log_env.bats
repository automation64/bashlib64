setup() {
  . "${PROJECT_BL64_BUILD}/bashlib64.bash"
}

@test "constants are set" {

  [[ "$BL64_LOG_TYPE_FILE" == 'F' ]] && \
  [[ "$BL64_LOG_CATEGORY_INFO" == 'info' ]] && \
  [[ "$BL64_LOG_CATEGORY_TASK" == 'task' ]] && \
  [[ "$BL64_LOG_CATEGORY_DEBUG" == 'debug' ]] && \
  [[ "$BL64_LOG_CATEGORY_WARNING" == 'warning' ]] && \
  [[ "$BL64_LOG_CATEGORY_ERROR" == 'error' ]] && \
  [[ "$BL64_LOG_CATEGORY_RECORD" == 'record' ]]

}
