#!/bin/bash

. ./.env || exit 1

project_bl64_modules='log msg os core'
project_bl64_file=''
project_bl64_lib="$PROJECT_BL64_BUILD/bashlib64.bash"

cat "$PROJECT_BL64_SRC/bashlib64-core.header" > "$project_bl64_lib"
for project_bl64_file in $project_bl64_modules; do
  grep -v -E '^#.*|^$' "${PROJECT_BL64_SRC}/bashlib64-${project_bl64_file}.env" >> "$project_bl64_lib"
done

for project_bl64_file in $project_bl64_modules; do
  grep -v -E '^#.*|^$' "${PROJECT_BL64_SRC}/bashlib64-${project_bl64_file}.bash" >> "$project_bl64_lib"
done
