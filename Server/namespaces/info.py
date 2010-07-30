import os
import rpc
from models import Person


class InfoNamespace(rpc.Namespace):

  def echo(self):
    self.response = self.request

  def environment(self):
    self.response["server"] = os.environ['SERVER_SOFTWARE']
    self.response["app_id"] = os.environ['APPLICATION_ID']

  def postdeploy(self):
    if not Person.all(keys_only=True).fetch(limit=1):
      key = Person(
        key_name="ampatspell@gmail.com", 
        login="ampatspell", 
        password="freak", 
        email="ampatspell@gmail.com").put()
      
      self.response["key"] = str(key)
    else:
      self.respond_with_error("At least one user exists")
