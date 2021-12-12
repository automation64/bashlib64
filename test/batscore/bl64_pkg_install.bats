setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
}

@test "bl64_pkg_install: prepare package manager" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  set +u # to avoid IFS missing error in run function
  run /usr/bin/sudo /bin/bash -c ". ${DEVBL64_TEST}/lib/bashlib64.bash bl64_pkg_install file"
}
