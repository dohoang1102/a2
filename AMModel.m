//
//  AMModel.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMModel.h"


@implementation AMModel
@synthesize key;

- (void)dealloc
{
  self.key = nil;
  [super dealloc];
}

@end
