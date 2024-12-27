#!/bin/bash
# Git pre-push hook to generate changelog.
#
# Copy this file to .git/hooks/pre-push

just generate-changelog
git commit -am "chore: update changelog"
exit 0
