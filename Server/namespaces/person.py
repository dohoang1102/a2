import rpc
from rpc import require_user
from google.appengine.ext import db
from models import Person

class PersonNamespace(rpc.Namespace):
  
  @require_user
  def all(self):
    people = Person.all().with_cursor(self.request.get("cursor"))
    self.response["data"] = [person.to_json() for person in people]
    self.response["cursor"] = people.cursor()
  
  @require_user
  def get(self):
    person = Person.get(db.Key(encoded=self.request["key"]))
    self.respond_with(person.to_json())
  
  @require_user
  def create(self):
    login = self.request.get("login")
    password = self.request.get("password")
    email = self.request.get("email")
    
    def tx(login, password, email):
      person = Person.get_by_key_name(email)
      if not person:
        return Person(key_name=email, login=login, password=password, email=email).put()

    key = db.run_in_transaction(tx, login, password, email)
    if key:
      self.response["key"] = str(key)
    else:
      self.respond_with_error("Person with email %s already exists" % email)
  
  @require_user
  def update(self):
    key = self.request["key"]
    login = self.request.get("login")

    def tx(key, login):
      person = Person.get(db.Key(encoded=key))
      person.login = login
      person.put()
    
    db.run_in_transaction(tx, key, login)
    self.response["login"] = login
  
  @require_user
  def destroy(self):
    person = Person.get(db.Key(encoded=self.request.get("key")))
    if person:
      person.delete()

  @require_user
  def current(self):
    token = self.request["token"]
    person = Person.get_by_login_token(token)
    if person:
      self.response = person.to_json()
    else:
      self.respond_with_error("Person by token not found")
