setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_os_set_command: common globals are set" {

  [[ -n "${BL64_OS_CMD_AWK}" ]] && \
  [[ -n "${BL64_OS_CMD_TAR}" ]] && \
  [[ -n "${BL64_OS_CMD_USERADD}" ]] && \
  [[ -n "${BL64_OS_CMD_CAT}" ]] && \
  [[ -n "${BL64_OS_CMD_CHMOD}" ]] && \
  [[ -n "${BL64_OS_CMD_CHOWN}" ]] && \
  [[ -n "${BL64_OS_CMD_CP}" ]] && \
  [[ -n "${BL64_OS_CMD_DATE}" ]] && \
  [[ -n "${BL64_OS_CMD_GREP}" ]] && \
  [[ -n "${BL64_OS_CMD_HOSTNAME}" ]] && \
  [[ -n "${BL64_OS_CMD_ID}" ]] && \
  [[ -n "${BL64_OS_CMD_LS}" ]] && \
  [[ -n "${BL64_OS_CMD_MKDIR}" ]] && \
  [[ -n "${BL64_OS_CMD_MKTEMP}" ]] && \
  [[ -n "${BL64_OS_CMD_MV}" ]] && \
  [[ -n "${BL64_OS_CMD_RM}" ]]

}

@test "bl64_os_set_command: common commands are set" {

  [[ -x "${BL64_OS_CMD_AWK}" ]] && \
  [[ -x "${BL64_OS_CMD_TAR}" ]] && \
  [[ -x "${BL64_OS_CMD_USERADD}" ]] && \
  [[ -x "${BL64_OS_CMD_CAT}" ]] && \
  [[ -x "${BL64_OS_CMD_CHMOD}" ]] && \
  [[ -x "${BL64_OS_CMD_CHOWN}" ]] && \
  [[ -x "${BL64_OS_CMD_CP}" ]] && \
  [[ -x "${BL64_OS_CMD_DATE}" ]] && \
  [[ -x "${BL64_OS_CMD_GREP}" ]] && \
  [[ -x "${BL64_OS_CMD_HOSTNAME}" ]] && \
  [[ -x "${BL64_OS_CMD_ID}" ]] && \
  [[ -x "${BL64_OS_CMD_LS}" ]] && \
  [[ -x "${BL64_OS_CMD_MKDIR}" ]] && \
  [[ -x "${BL64_OS_CMD_MKTEMP}" ]] && \
  [[ -x "${BL64_OS_CMD_MV}" ]] && \
  [[ -x "${BL64_OS_CMD_RM}" ]]

}
