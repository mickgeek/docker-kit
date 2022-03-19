#!/bin/sh
set -e

cd /home/apps/py

if [ "$1" = 'python3' ]; then
    python3 -m venv .
    . ./bin/activate
    pip install -r ./requirements.txt
fi

exec "$@" ./app.py
