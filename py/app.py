# -*- coding: utf-8 -*-

from wsgiref.simple_server import make_server
from json import JSONEncoder

class Application():
    "Represents the class that starts the WSGI application."
    def __call__(self, environ, start_response):
        start_response('200 OK', [('Content-Type', 'application/json')])
        return [JSONEncoder().encode({'text': 'It works! Your Python application can grow up.'}).encode('utf-8')]

if __name__ == '__main__':
    app = Application()
    make_server('0.0.0.0', 8080, app).serve_forever()
