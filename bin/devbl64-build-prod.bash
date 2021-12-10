#!/bin/bash

. ./.env || exit 1

project_bl64_modules='os msg log check pkg'
project_bl64_file=''
project_bl64_lib="$DEVBL64_BUILD/bashlib64.bash"

cat "$DEVBL64_SRC/bl64-core.header" > "$project_bl64_lib"
for project_bl64_file in $project_bl64_modules; do
  grep -v -E '^#.*|^$' "${DEVBL64_SRC}/bl64-${project_bl64_file}.env" >> "$project_bl64_lib"
done

for project_bl64_file in $project_bl64_modules; do
  grep -v -E '^#.*|^$' "${DEVBL64_SRC}/bl64-${project_bl64_file}.bash" >> "$project_bl64_lib"
done

cat "$DEVBL64_SRC/bl64-core.env" >> "$project_bl64_lib"
cat "$DEVBL64_SRC/bl64-core.bash" >> "$project_bl64_lib"
