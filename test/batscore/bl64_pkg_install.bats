setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "prepare package manager" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run /usr/bin/sudo /bin/bash -c ". ${DEVBL64_TEST}/lib/bashlib64.bash bl64_pkg_install"
}
