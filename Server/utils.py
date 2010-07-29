import os
import random
import string
import hashlib
import unicodedata
from google.appengine.ext import webapp
from google.appengine.ext.webapp import template

class BaseHandler(webapp.RequestHandler):
  def render_view(self, name, values=None):
    if not values:
      values = {}
    path = os.path.join(os.path.dirname(__file__), "views", name + ".html")
    self.response.out.write(template.render(path, values))
    
  def render_text(self, text):
    self.response.out.write(text)

def generate_random_string(length):
  return ''.join(random.choice(string.letters + string.digits) for i in xrange(length))

def string_sha1(input):
  return sha1(unicodedata.normalize('NFKD', input).encode('ascii','ignore').lower())

def sha1(input):
  return hashlib.sha1(input).hexdigest()
