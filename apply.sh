#!/bin/bash
stow -v -S */ -t ~

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
