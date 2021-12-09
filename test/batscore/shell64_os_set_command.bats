setup() {
  SHELL64_LIB="${PROJECT_SHELL64_SRC}"
  . "${SHELL64_LIB}/shell64.bash"
}

@test "common globals are set" {

[[ -n "${SHELL64_OS_CMD_AWK}" ]] && \
[[ -n "${SHELL64_OS_CMD_SUDO}" ]] && \
[[ -n "${SHELL64_OS_CMD_USERADD}" ]] && \
[[ -n "${SHELL64_OS_CMD_DATE}" ]] && \
[[ -n "${SHELL64_OS_CMD_HOSTNAME}" ]] && \
[[ -n "${SHELL64_OS_CMD_MKDIR}" ]] && \
[[ -n "${SHELL64_OS_CMD_RM}" ]] && \
[[ -n "${SHELL64_OS_CMD_CHMOD}" ]] && \
[[ -n "${SHELL64_OS_CMD_CHOWN}" ]] && \
[[ -n "${SHELL64_OS_CMD_CP}" ]] && \
[[ -n "${SHELL64_OS_CMD_LS}" ]] && \
[[ -n "${SHELL64_OS_CMD_ID}" ]] && \
[[ -n "${SHELL64_OS_CMD_CAT}" ]] && \
[[ -n "${SHELL64_OS_CMD_APT}" ]]

}

@test "common commands are set" {

[[ -x "${SHELL64_OS_CMD_AWK}" ]] && \
[[ -x "${SHELL64_OS_CMD_SUDO}" ]] && \
[[ -x "${SHELL64_OS_CMD_USERADD}" ]] && \
[[ -x "${SHELL64_OS_CMD_DATE}" ]] && \
[[ -x "${SHELL64_OS_CMD_HOSTNAME}" ]] && \
[[ -x "${SHELL64_OS_CMD_MKDIR}" ]] && \
[[ -x "${SHELL64_OS_CMD_RM}" ]] && \
[[ -x "${SHELL64_OS_CMD_CHMOD}" ]] && \
[[ -x "${SHELL64_OS_CMD_CHOWN}" ]] && \
[[ -x "${SHELL64_OS_CMD_CP}" ]] && \
[[ -x "${SHELL64_OS_CMD_LS}" ]] && \
[[ -x "${SHELL64_OS_CMD_ID}" ]] && \
[[ -x "${SHELL64_OS_CMD_CAT}" ]] && \
[[ -x "${SHELL64_OS_CMD_APT}" ]]

}
