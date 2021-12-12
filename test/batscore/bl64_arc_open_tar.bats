setup() {
  BL64_LIB_STRICT=0
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "bl64_arc_open_tar: both parameters are not present" {

  run bl64_arc_open_tar
  [[ "$status" == $BL64_ARC_ERROR_MISSING_PARAMETER ]]
  [[ "$output" == *${_BL64_ARC_TXT_MISSING_PARAMETER}* ]]

}

@test "bl64_arc_open_tar: destination is not present" {

  run bl64_arc_open_tar '/dev/null'
  [[ "$status" == $BL64_ARC_ERROR_MISSING_PARAMETER ]]
  [[ "$output" == *${_BL64_ARC_TXT_MISSING_PARAMETER}* ]]

}

@test "bl64_arc_open_tar: destination is invalid" {

  run bl64_arc_open_tar '/dev/null' '/dev/null'
  [[ "$status" == $BL64_ARC_ERROR_INVALID_DESTINATION ]]
  [[ "$output" == *${_BL64_ARC_TXT_DST_NOT_DIRECTORY}* ]]

}
