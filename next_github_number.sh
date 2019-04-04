#!/bin/bash
#
# get the next github/issue number in the current repo

set -e

origin_url=`git remote get-url origin`

case "$origin_url" in
    git@github.com:*)
        repo=${origin_url#*:}
        ;;
    *)
        echo "unsupported url $origin_url" >&2
        exit 1
        ;;
esac

echo $repo

# Fetch the current GitHub issue number, add one to it -- presto! The likely
# next PR number.
curl -s "https://api.github.com/repos/$repo/issues?state=all&per_page=1" |
    jq -r ".[0].number + 1"
