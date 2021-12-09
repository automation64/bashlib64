setup() {
  BL64_LIB="${PROJECT_BL64_SRC}"
  . "${BL64_LIB}/bashlib64.bash"
}

@test "1: identify platform()" {
  [[ "$BL64_OS_DISTRO" != 'UNKNOWN' ]]
}
