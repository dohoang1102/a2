from datetime import datetime
from google.appengine.ext import db
from google.appengine.api import memcache
import utils



class ModelMixin:
  def to_json(self):
    json = {}
    json["key"] = str(self.key())
    for property in self.__class__.json_properties:
      value = getattr(self, property.name)
      if type(value) == datetime:
        value = int(value.strftime("%s"))
      elif isinstance(value, db.Model):
        value = str(value.key())
      json[property.name] = value
    return json



class Person(db.Model, ModelMixin):
  login    = db.StringProperty(required=True)
  password = db.StringProperty(required=True)
  email    = db.StringProperty(required=True)
  created  = db.DateTimeProperty(auto_now_add=True)

  json_properties = [login, email, created]
  
  @classmethod
  def get_by_login_and_password(cls, login, password):
    if login and password:
      return cls.gql("WHERE login = :login AND password = :password", login=login, password=password).get()
  
  @classmethod
  def create_login_token(cls, login, password):
    person = cls.get_by_login_and_password(login, password)
    if person:
      token = utils.generate_random_string(48)
      memcache.set(cls._get_memcache_key_for_token(token), str(person.key()), time=60*60*8)
      return token
      
  @classmethod
  def get_key_by_login_token(cls, token):
    if token:
      encoded_key = memcache.get(cls._get_memcache_key_for_token(token))
      if encoded_key:
        return db.Key(encoded=encoded_key)
  
  @classmethod
  def get_by_login_token(cls, token):
    key = cls.get_key_by_login_token(token)
    if key:
      return cls.get(key)
  
  @classmethod
  def destroy_login_token(cls, token):
    if token:
      memcache.delete(cls._get_memcache_key_for_token(token))
    pass
  
  @classmethod
  def _get_memcache_key_for_token(cls, token):
    return "login-%s" % token



class Project(db.Model, ModelMixin):
  name = db.StringProperty(required=True)
  created  = db.DateTimeProperty(auto_now_add=True)
  owner = db.ReferenceProperty(Person)

  json_properties = [name, created, owner]


class Message(db.Model, ModelMixin):
  body = db.StringProperty(required=True)
  created = db.DateTimeProperty(auto_now_add=True)
  index = db.IntegerProperty(required=True)
  
  json_properties = [body, index, created]


class Count(db.Model):
  value = db.IntegerProperty(required=True)

  @classmethod
  def get_value(cls, name):
    count = cls.get_by_key_name(name)
    if count:
      return count.value
    return 0
  
  @classmethod
  def increment_value(cls, name, delta):
    count = cls.get_or_insert(name, value=0)
    count.value += delta
    count.put()
