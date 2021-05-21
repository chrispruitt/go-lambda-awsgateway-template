#!/bin/bash

find test -type f | while read testfile; do
  echo "---:> $testfile"
  curl -w "\n" --data-binary "@$testfile" http://localhost:9001/2015-03-31/functions/myfunction/invocations
  echo
done
