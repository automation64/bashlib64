  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
    # X_CODE_PLACEHOLDER_X
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    # X_CODE_PLACEHOLDER_X
    ;;
  ${BL64_OS_SLES}-*)
    # X_CODE_PLACEHOLDER_X
    ;;
  ${BL64_OS_ALP}-*)
    # X_CODE_PLACEHOLDER_X
    ;;
  ${BL64_OS_ARC}-*)
    # X_CODE_PLACEHOLDER_X
    ;;
  ${BL64_OS_MCOS}-*)
    # X_CODE_PLACEHOLDER_X
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
