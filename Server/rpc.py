import logging
from django.utils import simplejson
from google.appengine.ext import db
from models import Person


class Error(Exception):
  pass


class NotLoggedIn(Error):
  pass


def require_user(f):
  def new(self, *args, **kwargs):
    key = Person.get_key_by_login_token(self.request.get("token"))
    if not key:
      raise NotLoggedIn("Not logged in")
    self._current_user_key = key
    return f(self, *args, **kwargs)
  return new
  

class Namespace(object):
  def initialize(self, request):
    self.request  = request
    self.response = {"status":"success"}
  
  def missing_action(self, namespace, action):
    raise Error("Action not found %s/%s" % (str(namespace), str(action)))
    
  def handle_exception(self, e, namespace, action):
    if isinstance(e, db.Error):
      self.respond_with_error(e)
    else:
      raise
  
  def respond_with(self, dict):
    self.response["data"] = dict
  
  def respond_with_error(self, message):
    self.response = {"status":"failed","reason":str(message)}

  def current_user_key(self):
    if not self._current_user_key:
      raise Error("current_user_key() may be used only in actions decorated with @require_user")
    return self._current_user_key


class RPCService(object):
    
  def __init__(self, namespace_mappings):
    self._namespace_mappings = namespace_mappings
    RPCService.active_instance = self
  
  def invoke(self, namespace_name, action_name, input_string):
    if not action_name or action_name[0] == '_':
      raise Error("Invalid action %s/%s" % (str(namespace_name), str(action_name)))

    input_dict = self._parse_input(input_string)
    
    namespace = None
    for name, namespace_class in self._namespace_mappings:
      if name == namespace_name:
        namespace = namespace_class()
        namespace.initialize(input_dict)
        break
    
    if not namespace:
      raise Error("Namespace %s not found" % str(namespace_name))
    
    function = getattr(namespace, action_name, None)
    if function:
      try:
        function()
      except Exception, e:
        namespace.handle_exception(e, namespace_name, action_name)
    else:
      namespace.missing_action(namespace_name, action_name)
    
    output_dict = namespace.response
    if output_dict:
      json = simplejson.dumps(output_dict, sort_keys=True, indent=2)
      if json:
        return json
      else:
        return "{}"
    else:
      return "{}"
    
  def _parse_input(self, string):
    try:
      if string:
        return simplejson.loads(string)
      else:
        return {}
    except ValueError, e:
      raise Error("Invalid input: %s" % e)
