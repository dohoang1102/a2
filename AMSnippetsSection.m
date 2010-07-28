//
//  AMSnippetsSection.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSnippetsSection.h"
#import "AMSnippet.h"


@implementation AMSnippetsSection

- (id)init
{
  if(self = [super init]) {
    // [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
  }
  return self;
}

- (void)timerDidFire:(NSTimer *)timer
{
  static NSUInteger index = 0;
  AMSnippet *snippet = [[[AMSnippet alloc] initWithTitle:[NSString stringWithFormat:@"Snippet #%i", index]] autorelease];
  [self insertObject:snippet inModelsAtIndex:[self countOfModels]];
  index++;
}

- (void)dealloc
{
  [super dealloc];
}

- (NSString *)localizedName
{
  return @"Code Snippets";
}

- (NSString *)persistentName
{
  return @"snippets";
}

@end
