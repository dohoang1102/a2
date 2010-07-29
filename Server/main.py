#!/usr/bin/env python

from google.appengine.ext import webapp
from google.appengine.ext.webapp import util
import handlers

from rpc import RPCService
from namespaces import *

RPCService([
  ("info",    info.InfoNamespace),
  ("person",  person.PersonNamespace),
  ("session", session.SessionNamespace)
])

application = webapp.WSGIApplication([
  ( '/',    handlers.MainHandler),
  ('/test', handlers.RPCFormHandler),
  (r'/rpc/([a-zA-Z]+)/([a-zA-Z]+)', handlers.RPCHandler)
], debug=True)

def main():
  util.run_wsgi_app(application)

if __name__ == '__main__':
  main()
