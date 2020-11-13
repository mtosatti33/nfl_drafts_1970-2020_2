#!/usr/bin/env bash

if [ -h /usr/bin/nfl-drafts ]; then 
    sudo rm /usr/bin/nfl-drafts
fi

if [ -e $(pwd)/Drafts ]; then
    sudo ln -s $(pwd)/Drafts /usr/bin/nfl-drafts
else
    echo "Binary not found"
    exit 1
fi
