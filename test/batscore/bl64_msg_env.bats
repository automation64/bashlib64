setup() {
  . "${PROJECT_BL64_BUILD}/bashlib64.bash"
}

@test "constants are set" {

  [[ "$_BL64_MSG_TXT_USAGE" == 'Usage' ]] && \
  [[ "$_BL64_MSG_TXT_COMMANDS" == 'Commands' ]] && \
  [[ "$_BL64_MSG_TXT_FLAGS" == 'Flags' ]] && \
  [[ "$_BL64_MSG_TXT_PARAMETERS" == 'Parameters' ]] && \
  [[ "$_BL64_MSG_TXT_ERROR" == 'Error' ]] && \
  [[ "$_BL64_MSG_TXT_INFO" == 'Info' ]] && \
  [[ "$_BL64_MSG_TXT_TASK" == 'Task' ]] && \
  [[ "$_BL64_MSG_TXT_DEBUG" == 'Debug' ]] && \
  [[ "$_BL64_MSG_TXT_WARNING" == 'Warning' ]] && \
  [[ "$_BL64_MSG_HEADER" == '%s@%s[%(%d/%b/%Y-%H:%M:%S)T]' ]]

}
