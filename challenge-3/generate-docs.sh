#!/bin/bash

directories=("main-infra" "setup-backend")

for dir in "${directories[@]}"; do
  echo "Generating documentation for $dir"
  (cd "$dir" && terraform-docs markdown .)
done