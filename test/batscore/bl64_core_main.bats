setup() {
  . "${DEVBL64_BUILD}/bashlib64.bash"
}

@test "lang is set" {
  [[ "$LANG" == 'C' ]] && \
  [[ "$LC_ALL" == 'C' ]] && \
  [[ "$LANGUAGE" == 'C' ]]
}
