setup() {
  . "${PROJECT_BL64_BUILD}/bashlib64.bash"
}

@test "common globals are set" {

[[ -n "${BL64_OS_CMD_AWK}" ]] && \
[[ -n "${BL64_OS_CMD_SUDO}" ]] && \
[[ -n "${BL64_OS_CMD_USERADD}" ]] && \
[[ -n "${BL64_OS_CMD_DATE}" ]] && \
[[ -n "${BL64_OS_CMD_HOSTNAME}" ]] && \
[[ -n "${BL64_OS_CMD_MKDIR}" ]] && \
[[ -n "${BL64_OS_CMD_RM}" ]] && \
[[ -n "${BL64_OS_CMD_CHMOD}" ]] && \
[[ -n "${BL64_OS_CMD_CHOWN}" ]] && \
[[ -n "${BL64_OS_CMD_CP}" ]] && \
[[ -n "${BL64_OS_CMD_LS}" ]] && \
[[ -n "${BL64_OS_CMD_ID}" ]] && \
[[ -n "${BL64_OS_CMD_CAT}" ]] && \
[[ -n "${BL64_OS_CMD_APT}" ]]

}

@test "common commands are set" {

[[ -x "${BL64_OS_CMD_AWK}" ]] && \
[[ -x "${BL64_OS_CMD_SUDO}" ]] && \
[[ -x "${BL64_OS_CMD_USERADD}" ]] && \
[[ -x "${BL64_OS_CMD_DATE}" ]] && \
[[ -x "${BL64_OS_CMD_HOSTNAME}" ]] && \
[[ -x "${BL64_OS_CMD_MKDIR}" ]] && \
[[ -x "${BL64_OS_CMD_RM}" ]] && \
[[ -x "${BL64_OS_CMD_CHMOD}" ]] && \
[[ -x "${BL64_OS_CMD_CHOWN}" ]] && \
[[ -x "${BL64_OS_CMD_CP}" ]] && \
[[ -x "${BL64_OS_CMD_LS}" ]] && \
[[ -x "${BL64_OS_CMD_ID}" ]] && \
[[ -x "${BL64_OS_CMD_CAT}" ]] && \
[[ -x "${BL64_OS_CMD_APT}" ]]

}
