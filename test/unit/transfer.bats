#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_cmd_transfer requires name and new_owner arguments" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_transfer "" "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_transfer requires new_owner argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_transfer "owner/repo" "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_transfer is idempotent when already owned by target" {
  # Verify idempotent check exists
  grep "already owned by" gh-repo-mgmt | grep -q "idempotent"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_transfer checks if repo exists" {
  # Verify existence check
  grep "p6_cmd_transfer" gh-repo-mgmt -A 15 | grep -q "does not exist"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_transfer checks if new owner exists" {
  # Verify new owner existence check
  grep "p6_cmd_transfer" gh-repo-mgmt -A 35 | grep "does not exist" | grep -q "new_owner"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_transfer uses POST method to transfer endpoint" {
  # Verify POST API call to transfer endpoint
  grep "p6_cmd_transfer" gh-repo-mgmt -A 40 | grep -q "POST.*transfer"
  [ "$?" -eq 0 ]
}

@test "transfer command is in case statement" {
  grep "case \$cmd in" gh-repo-mgmt -A 6 | grep -q "transfer)"
  [ "$?" -eq 0 ]
}

@test "transfer command is documented in usage" {
  grep "transfer <name>" gh-repo-mgmt | grep -q "Transfer repository ownership"
  [ "$?" -eq 0 ]
}
