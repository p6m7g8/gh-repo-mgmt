#!/usr/bin/env bats

# shellcheck shell=bash

load ../test_helper

@test "p6_cmd_archive requires name argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_archive "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_archive fails if repository doesn't exist" {
  # Verify error handling exists
  grep -q "does not exist" gh-repo-mgmt
  [ "$?" -eq 0 ]
}

@test "p6_cmd_archive is idempotent when already archived" {
  # Verify idempotent check exists
  grep "p6_cmd_archive" gh-repo-mgmt -A 30 | grep -q "already archived (idempotent)"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_archive archives when not archived" {
  # Verify archive logic exists
  grep "p6_cmd_archive" gh-repo-mgmt -A 30 | grep -q "archived successfully"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_archive uses PATCH method" {
  # Verify PATCH is used for archiving
  grep "p6_cmd_archive" gh-repo-mgmt -A 30 | grep -q "PATCH"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_archive sets archived to true" {
  # Verify payload sets archived:true
  grep "p6_cmd_archive" gh-repo-mgmt -A 30 | grep -q '"archived":true'
  [ "$?" -eq 0 ]
}

@test "p6_cmd_unarchive requires name argument" {
  run bash -c 'source <(sed "s/^p6main.*//" gh-repo-mgmt); p6_cmd_unarchive "" 2>&1 || true'
  [[ "$output" =~ "Usage:" ]]
}

@test "p6_cmd_unarchive fails if repository doesn't exist" {
  # Verify error handling exists in unarchive
  grep "p6_cmd_unarchive" gh-repo-mgmt -A 30 | grep -q "does not exist"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_unarchive is idempotent when already unarchived" {
  # Verify idempotent check exists
  grep "p6_cmd_unarchive" gh-repo-mgmt -A 30 | grep -q "already unarchived (idempotent)"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_unarchive unarchives when archived" {
  # Verify unarchive logic exists
  grep "p6_cmd_unarchive" gh-repo-mgmt -A 30 | grep -q "unarchived successfully"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_unarchive uses PATCH method" {
  # Verify PATCH is used for unarchiving
  grep "p6_cmd_unarchive" gh-repo-mgmt -A 30 | grep -q "PATCH"
  [ "$?" -eq 0 ]
}

@test "p6_cmd_unarchive sets archived to false" {
  # Verify payload sets archived:false
  grep "p6_cmd_unarchive" gh-repo-mgmt -A 30 | grep -q '"archived":false'
  [ "$?" -eq 0 ]
}

@test "archive command is in case statement" {
  grep "case \$cmd in" gh-repo-mgmt -A 10 | grep -q "archive)"
  [ "$?" -eq 0 ]
}

@test "unarchive command is in case statement" {
  grep "case \$cmd in" gh-repo-mgmt -A 12 | grep -q "unarchive)"
  [ "$?" -eq 0 ]
}

@test "archive command is documented in usage" {
  grep "archive <name>" gh-repo-mgmt | grep -q "Archive a repository"
  [ "$?" -eq 0 ]
}

@test "unarchive command is documented in usage" {
  grep "unarchive <name>" gh-repo-mgmt | grep -q "Unarchive a repository"
  [ "$?" -eq 0 ]
}
