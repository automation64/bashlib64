#######################################
# BashLib64 / Module / Functions / Interact with RESTful APIs
#######################################

#######################################
# Call RESTful API using Curl
#
# * API calls are executed using Curl
# * Curl is used directly instead of the wrapper to minimize shell expansion unintented modifications
# * The caller is responsible for properly url-encoding the query when needed
# * Using curl --fail option to capture HTTP errors
#
# Arguments:
#   $1: API server FQDN. Format: PROTOCOL://FQDN
#   $2: API path. Format: Full path (/X/Y/Z)
#   $3: RESTful method. Format: $BL64_API_METHOD_*. Default: $BL64_API_METHOD_GET
#   $4: API query to be appended to the API path. Format: url encoded string. Default: none
#   $@: additional arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   0: API call executed. Warning: curl exit status only, not the HTTP status code
#   >: API call failed or unable to call API
#######################################
function bl64_api_call() {
  bl64_dbg_lib_show_function "$@"
  local api_url="$1"
  local api_path="$2"
  local api_method="${3:-${BL64_API_METHOD_GET}}"
  local api_query="${4:-${BL64_VAR_NULL}}"
  local debug="$BL64_RXTX_SET_CURL_SILENT"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_command "$BL64_RXTX_CMD_CURL" &&
    bl64_check_parameter 'api_url' &&
    bl64_check_parameter 'api_path' || return $?

  [[ "$api_query" == "${BL64_VAR_NULL}" ]] && api_query=''
  shift
  shift
  shift
  shift

  bl64_dbg_lib_command_is_enabled && debug="${BL64_RXTX_SET_CURL_VERBOSE} ${BL64_RXTX_SET_CURL_INCLUDE}"
  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  bl64_bsh_job_try "$BL64_API_CALL_SET_MAX_RETRIES" "$BL64_API_CALL_SET_WAIT" \
    "$BL64_RXTX_CMD_CURL" \
    $BL64_RXTX_SET_CURL_FAIL \
    $BL64_RXTX_SET_CURL_REDIRECT \
    $BL64_RXTX_SET_CURL_SECURE \
    $BL64_RXTX_SET_CURL_REQUEST ${api_method} \
    $debug \
    "${api_url}${api_path}${api_query}" \
    "$@"
  bl64_dbg_lib_trace_stop
  status=$?
  ((status != 0)) && bl64_msg_show_lib_error "API call failed (${api_url}${api_path})"
  return "$status"
}

#######################################
# Converts ASCII-127 string to URL compatible format
#
# * Target is the QUERY segment of the URL:
# *   PROTOCOL://FQDN/QUERY
# * Conversion is done using sed
# * Input is assumed to be encoded in ASCII-127
# * Conversion is done as per RFC3986
# *  unreserved: left as is
# *  reserved: converted
# *  remaining ascii-127 non-control chars: converted
# * Warning: sed regexp is not consistent across versions and vendors. Using [] when \ is not possible to scape special chars
#
# Arguments:
#   $1: String to convert. Must be terminated by \n
# Outputs:
#   STDOUT: encoded string
#   STDERR: execution errors
# Returns:
#   0: successfull execution
#   >0: failed to convert
#######################################
function bl64_api_url_encode() {
  bl64_dbg_lib_show_function "$@"
  local raw_string="$1"

  bl64_check_parameter 'raw_string' || return $?

  echo "$raw_string" |
    bl64_txt_run_sed \
      -e 's/%/%25/g' \
      -e 's/ /%20/g' \
      -e 's/:/%3A/g' \
      -e 's/\//%2F/g' \
      -e 's/[?]/%3F/g' \
      -e 's/#/%23/g' \
      -e 's/@/%40/g' \
      -e 's/\[/%5B/g' \
      -e 's/\]/%5D/g' \
      -e 's/\!/%21/g' \
      -e 's/\$/%24/g' \
      -e 's/&/%26/g' \
      -e "s/'/%27/g" \
      -e 's/[(]/%28/g' \
      -e 's/[)]/%29/g' \
      -e 's/\*/%2A/g' \
      -e 's/[+]/%2B/g' \
      -e 's/,/%2C/g' \
      -e 's/;/%3B/g' \
      -e 's/=/%3D/g' \
      -e 's/"/%22/g' \
      -e 's/</%3C/g' \
      -e 's/>/%3E/g' \
      -e 's/\^/%5E/g' \
      -e 's/`/%60/g' \
      -e 's/{/%7B/g' \
      -e 's/}/%7D/g' \
      -e 's/[|]/%7C/g' \
      -e 's/[\]/%5C/g'
}
