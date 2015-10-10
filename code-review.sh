#!/bin/bash

touch .blamefile
truncate --size 0 .blamefile

for i in $(git status | grep modified | sed -e 's/^\s*modified:\s*//'); do
  git blame $i -p | grep author-mail >> .blamefile
done

cat .blamefile | sort | uniq -c | sort -n | tail -n 2 | sed \
  -e 's/author-mail//' \
  -e 's/<//' \
  -e 's/>//' \
  -e 's/\s*//' \
