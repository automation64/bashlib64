setup() {
  . "${DEVBL64_BUILD}/bashlib64.bash"
}

@test "commands are set" {
  [[ "$BL64_PKG_CMD_APT" == '/usr/bin/apt-get' ]] && \
  [[ "$BL64_PKG_CMD_DNF" == '/usr/bin/dnf' ]] && \
  [[ "$BL64_PKG_CMD_YUM" == '/usr/bin/yum' ]]
}

@test "alias are set" {
  [[ "$BL64_PKG_ALIAS_APT_UPDATE" == "$BL64_PKG_CMD_APT update" ]] && \
  [[ "$BL64_PKG_ALIAS_APT_INSTALL" == "$BL64_PKG_CMD_APT --assume-yes install" ]] && \
  [[ "$BL64_PKG_ALIAS_APT_CLEAN" == "$BL64_PKG_CMD_APT clean" ]] && \
  [[ "$BL64_PKG_ALIAS_DNF_CACHE" == "$BL64_PKG_CMD_DNF --color=never makecache" ]] && \
  [[ "$BL64_PKG_ALIAS_DNF_INSTALL" == "$BL64_PKG_CMD_DNF --color=never --nodocs --assumeyes install" ]] && \
  [[ "$BL64_PKG_ALIAS_DNF_CLEAN" == "$BL64_PKG_CMD_DNF clean all" ]]
}
