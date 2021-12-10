setup() {
  . "${PROJECT_BL64_BUILD}/bashlib64.bash"
}

@test "identify platform" {
  [[ "$BL64_OS_DISTRO" != 'UNKNOWN' ]]
}
