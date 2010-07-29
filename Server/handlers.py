import logging
from google.appengine.ext import webapp
from utils import BaseHandler
import rpc
from models import Person


class MainHandler(BaseHandler):
  def get(self):      
    self.render_view("index")


class RPCFormHandler(BaseHandler):
  def __init__(self):
    BaseHandler.__init__(self)
    self.rpc_service = rpc.RPCService.active_instance
  
  def get(self):    
    namespace = self.request.get('namespace')
    action    = self.request.get('action')
    content   = self.request.get('content')

    self.render_view("rpc/index", {
      "namespace":namespace,
      "action":action,
      "content":content
    })
    
  def post(self):
    namespace = ""
    action    = ""
    content   = ""
    result    = ""
    content   = ""
         
    if self.request.get("login", None) is not None:
      login    = self.request.get("login")
      password = self.request.get("password")
      token = Person.create_login_token(login, password)
      if token:
        namespace = "person"
        action = "all"
        content = "{\"token\":\"%s\"}" % token
    else:
      namespace = self.request.get('namespace')
      action    = self.request.get('action')
      content   = self.request.get('content')
      try:
        result = self.rpc_service.invoke(namespace, action, content)
      except rpc.Error, e:
        result = e
    
    self.render_view("rpc/index", {
      'namespace':namespace,
      'action':action,
      'content':content,
      'result':result
    })


class RPCHandler(BaseHandler):
  def __init__(self):
    BaseHandler.__init__(self)
    self.rpc_service = rpc.RPCService.active_instance

  def get(self, namespace, action):
    self.response.headers['Content-Type'] = 'text/plain; charset=utf-8'
    content = self.request.get('json')
    if not content:
      content = {}
    self.response.out.write(self.rpc_service.invoke(namespace, action, content))

  def post(self, namespace, action):
    self.response.headers['Content-Type'] = 'application/json; charset=utf-8'
    self.response.out.write(self.rpc_service.invoke(namespace, action, self.request.body))
