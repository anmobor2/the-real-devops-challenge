#!/bin/bash

directories=("setup-backend/test" "main-infra/environments_main-infra/test" )

for dir in "${directories[@]}"; do
  echo "Generating documentation for $dir"
  (cd "$dir" && terraform-docs markdown .)
done