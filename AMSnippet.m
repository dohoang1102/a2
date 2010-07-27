//
//  AMSnippet.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSnippet.h"


@implementation AMSnippet
@synthesize title, content;

- (id)initWithTitle:(NSString *)aTitle
{
  if(self = [super init]) {
    self.title = aTitle;
  }
  return self;
}

- (void)dealloc
{
  self.title = nil;
  self.content = nil;
  [super dealloc];
}

@end
