setup() {
  . "${PROJECT_BL64_BUILD}/bashlib64.bash"
}

@test "1: identify platform()" {
  [[ "$BL64_OS_DISTRO" != 'UNKNOWN' ]]
}
