#!/bin/bash

FUNCTION_NAME=$1

find test -type f | while read testfile; do
  echo "---:> $testfile"
  aws lambda invoke --function-name $FUNCTION_NAME --payload "fileb://$testfile" /dev/stdout 2>&1
  echo
done
