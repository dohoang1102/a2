//
//  AMSnippetViewController.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSnippetViewController.h"


@implementation AMSnippetViewController

- (id)init
{
  if(self = [super initWithNibName:@"Snippet" bundle:nil]) {
    // NSLog(@"%@ %s", [self className], _cmd);
  }
  return self;
}

- (void)dealloc
{
  // NSLog(@"%@ %s", [self className], _cmd);
  [super dealloc];
}

@end
