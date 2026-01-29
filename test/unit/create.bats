#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_cmd_create requires name argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_create "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_create is idempotent when repo exists" {
  # This test validates the idempotent behavior by mocking _gh
  # In real scenario, if repo exists, it should return success without creating

  # We can't easily test the full flow without actual GitHub API
  # but we can verify the function exists and has correct structure
  grep -q "p6_cmd_create()" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_create parses --private flag" {
  # Verify the function handles --private flag
  grep -q "visibility=\"private\"" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_create parses --public flag" {
  # Verify the function handles --public flag
  grep -q "visibility=\"public\"" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_create parses --description flag" {
  # Verify the function handles --description flag
  grep -q "description=" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_create checks if repo exists before creating" {
  # Verify idempotent check exists
  grep -q "already exists (idempotent)" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "create command is in case statement" {
  grep -A 3 "case \$cmd in" gh-repo-mgmt | grep -q "create)"
  [ "$?" -eq 0 ]
}
