//
//  AMDocumentController.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDocumentController.h"


@implementation AMDocumentController

- (id)init
{
  if(self = [super init]) {
    NSLog(@"%@ %s", [self className], _cmd);
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"%@ %s", [self className], _cmd);
  [super dealloc];
}

@end
