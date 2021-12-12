setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "bl64_core_main: lang is set" {
  [[ "$LANG" == 'C' ]] && \
  [[ "$LC_ALL" == 'C' ]] && \
  [[ "$LANGUAGE" == 'C' ]]
}
