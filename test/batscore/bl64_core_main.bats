setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "lang is set" {
  [[ "$LANG" == 'C' ]] && \
  [[ "$LC_ALL" == 'C' ]] && \
  [[ "$LANGUAGE" == 'C' ]]
}
