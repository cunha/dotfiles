#!/bin/bash
set -eu

ARCHIVE_LAST_YEAR=2018
MAILDIR=$HOME/Maildir
MAILDIR_CUR=$MAILDIR/cur

while read -r fn ; do
    fn=$(basename "$fn")
    timestamp=${fn%%.*}
    year=$(date --date "@$timestamp" +%Y)
    if [[ $year -gt $ARCHIVE_LAST_YEAR ]] ; then
        echo "$fn, year=$year: skipped"
        continue
    fi
    echo "$fn, year=$year: moved"
    mkdir -p "$MAILDIR/.$year/new"
    mkdir -p "$MAILDIR/.$year/cur"
    mkdir -p "$MAILDIR/.$year/tmp"
    mv "$MAILDIR_CUR/$fn" "$MAILDIR/.$year/cur/"
done < <(find "$MAILDIR_CUR" -type f | head)