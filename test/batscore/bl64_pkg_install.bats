setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_pkg_install: prepare package manager" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  set +u # to avoid IFS missing error in run function
  run /usr/bin/sudo /bin/bash -c ". $DEVBL64_TEST_BASHLIB64 bl64_pkg_install file"
}

@test "bl64_pkg_deploy: prepare package manager" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  set +u # to avoid IFS missing error in run function
  run /usr/bin/sudo /bin/bash -c ". $DEVBL64_TEST_BASHLIB64 bl64_pkg_deploy file"
}