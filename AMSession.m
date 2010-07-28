//
//  AMSession.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSession.h"


@implementation AMSession
@synthesize login, password;

- (void)dealloc
{
  self.login    = nil;
  self.password = nil;
  [super dealloc];
}

#pragma mark -

@end
