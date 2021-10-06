#!/bin/bash

echo "### BUILD ###"
echo
( cd .. && docker build -t yamllint . )

echo
echo "### RUN TEST ###"
echo
mkdir -p tmp
docker run -ti --rm -v `pwd`:/src -v `pwd`/tmp:/tmp -v `pwd`/../.yamllint:/src/.yamllint -e GITHUB_ENV=/tmp/gh.env yamllint

echo
echo "### SHOW GH ENV ###"
cat tmp/gh.env 
rm -rf tmp/gh.env
rmdir tmp

echo

