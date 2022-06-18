#!/bin/sh
set -e

cd /home/py

if [ "$1" = 'python3' ]; then
    python3 -m venv ./venv
    source ./venv/bin/activate

    pip install --upgrade pip
    pip install --requirement ./requirements.txt
fi

exec "$@" ./app.py
