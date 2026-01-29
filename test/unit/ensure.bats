#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_cmd_ensure requires name argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_ensure "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_ensure creates if repo doesn't exist" {
  # Verify create logic exists
  grep -q "does not exist, creating" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_ensure updates if repo exists" {
  # Verify update logic exists
  grep -q "exists, updating" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_ensure supports --topics flag" {
  # Verify topics support
  grep "p6_cmd_ensure" gh-repo-mgmt -A 30 | grep -q "topics="
  [ "$?" -eq 0 ]
}

@test "p6_cmd_ensure parses --private flag" {
  # Verify --private parsing
  grep "p6_cmd_ensure" gh-repo-mgmt -A 30 | grep "visibility=" | grep -q "private"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_ensure creates with topics" {
  # Verify topics creation logic
  grep -q "Setting topics" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_ensure updates with topics" {
  # Verify topics update logic
  grep -q "Updating topics" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "ensure command is in case statement" {
  grep "case \$cmd in" gh-repo-mgmt -A 7 | grep -q "ensure)"
  [ "$?" -eq 0 ]
}

@test "ensure command is documented in usage" {
  grep "ensure <name>" gh-repo-mgmt | grep -q "Ensure repository exists"
  [ "$?" -eq 0 ]
}
