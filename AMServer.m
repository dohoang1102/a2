//
//  AMServer.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMServer.h"


@implementation AMServer
@synthesize url, login, password;

- (id)initWithCoder:(NSCoder *)decoder
{
  if(self = [self init]) {
    self.url      = [decoder decodeObjectForKey:@"url"];
    self.login    = [decoder decodeObjectForKey:@"login"];
    self.password = [decoder decodeObjectForKey:@"password"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:url forKey:@"url"];
  [coder encodeObject:login forKey:@"login"];
  [coder encodeObject:password forKey:@"password"];
}

- (void)dealloc
{
  self.url = nil;
  self.login = nil;
  self.password = nil;
  [super dealloc];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"<%@ %p: %@ %@ %@>", [self className], self, url, login, password];
}

@end
