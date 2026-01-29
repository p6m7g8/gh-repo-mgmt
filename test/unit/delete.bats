#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_cmd_delete requires name argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_delete "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_delete is idempotent when repo doesn't exist" {
  # Verify idempotent check exists
  grep -q "already deleted" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_delete checks if repo exists before deleting" {
  # Verify existence check before deletion
  grep "does not exist" gh-repo-mgmt | grep -q "already deleted"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_delete uses DELETE method" {
  # Verify DELETE API call
  grep "p6_cmd_delete" gh-repo-mgmt -A 20 | grep -q "method DELETE"
  [ "$?" -eq 0 ]
}

@test "delete command is in case statement" {
  grep -A 3 "case \$cmd in" gh-repo-mgmt | grep -q "delete)"
  [ "$?" -eq 0 ]
}

@test "delete command is documented in usage" {
  grep "delete <name>" gh-repo-mgmt | grep -q "Delete a repository"
  [ "$?" -eq 0 ]
}
