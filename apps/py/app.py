# -*- coding: utf-8 -*-

from werkzeug.serving import run_simple
from werkzeug.wrappers import Response

def create_app():
    return Response('It works! Your Python application can grow up.')

if __name__ == '__main__':
    app = create_app()
    run_simple('0.0.0.0', 5000, app, use_debugger=True, use_reloader=True)
