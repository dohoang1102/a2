import rpc
from rpc import require_user
from google.appengine.ext import db
from models import Person


class SessionNamespace(rpc.Namespace):
  
  def create(self):
    login = self.request.get("login")
    password = self.request.get("password")
    
    token = Person.create_login_token(login, password)
    if token:
      self.respond_with({
        "key": token,
        "personKey": str(Person.get_by_login_token(token).key())
      })
    else:
      self.respond_with_error("Invalid login or password")
  
  @require_user
  def destroy(self):
    Person.destroy_login_token(self.request["token"])
