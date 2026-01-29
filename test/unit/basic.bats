#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_usage returns help text" {
  run p6_usage 0
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Usage:" ]]
  [[ "$output" =~ "Commands:" ]]
}

@test "p6main validates commands" {
  # Test that invalid commands are rejected
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6main invalid-command 2>&1 || true'
  [[ "$output" =~ "invalid cmd" ]]
}

@test "command normalization works" {
  # Test that update-topics and update_topics both work
  # This is tested by checking the case statement accepts both
  grep -q "update-topics)" gh-repo-mgmt
  [ "$?" -eq 0 ]
  grep -q "update_topics)" gh-repo-mgmt
  [ "$?" -eq 0 ]
}
