//
//  AMSite.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSite.h"
#import "AMServer.h"


@implementation AMSite
@synthesize server;

- (id)init
{
  if(self = [super init]) {
    server = [[AMServer alloc] init];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
  if(self = [super init]) {
    self.server = [decoder decodeObjectForKey:@"server"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:server forKey:@"server"];
}

- (void)dealloc
{
  self.server = nil;
  [super dealloc];
}

@end
