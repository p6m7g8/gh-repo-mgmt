#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_cmd_rename requires name and new_name arguments" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_rename "" "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_rename requires new_name argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_rename "owner/repo" "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_rename is idempotent when already has desired name" {
  # Verify idempotent check exists
  grep "already has name" gh-repo-mgmt | grep -q "idempotent"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_rename checks if repo exists" {
  # Verify existence check
  grep "p6_cmd_rename" gh-repo-mgmt -A 15 | grep -q "does not exist"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_rename checks if target name exists" {
  # Verify target existence check
  grep "p6_cmd_rename" gh-repo-mgmt -A 30 | grep "already exists" | grep -q "Error"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_rename uses PATCH method" {
  # Verify PATCH API call
  grep "p6_cmd_rename" gh-repo-mgmt -A 35 | grep -q "method PATCH"
  [ "$?" -eq 0 ]
}

@test "rename command is in case statement" {
  grep "case \$cmd in" gh-repo-mgmt -A 5 | grep -q "rename)"
  [ "$?" -eq 0 ]
}

@test "rename command is documented in usage" {
  grep "rename <name>" gh-repo-mgmt | grep -q "Rename a repository"
  [ "$?" -eq 0 ]
}
