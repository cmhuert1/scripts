#! /usr/bin/env bash

UPDATE_MSG="Already up to date."
DEPENDENCIES="./dependencies"
CUR_DIRECTORY="*/dependencies"
PREV_DIRECTORY="../"

function update {
    for f in */; do
        if [[ -d $f && $f != "dependencies/" ]]; then
            cd "./$f"
            OUTPUT="$(git pull)"
            echo "$f"
            if [[ $OUTPUT != $UPDATE_MSG ]]; then
                makepkg -sri
            fi
            echo "$OUTPUT"
            cd "$PREV_DIRECTORY"
        fi
    done
}

function main {
    cd $DEPENDENCIES
    update
    cd "$PREV_DIRECTORY"
    CUR_DIRECTORY="*/"
    update
}

main
