//
//  AMSectionEntry.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSectionEntry.h"


@implementation AMSectionEntryImpl

- (id)initWithName:(NSString *)aName
{
  if(self = [super init]) {
    name = [aName copy];
  }
  return self;
}

- (void)dealloc
{
  [name release];
  [super dealloc];
}

- (NSString *)sectionEntryName
{
  return [[name retain] autorelease];
}

- (NSUInteger)countOfNodes
{
  return 0;
}

- (id)objectInNodesAtIndex:(NSUInteger)index
{
  return nil;
}

- (BOOL)isLeafNode
{
  return YES;
}

- (NSString *)nodeLocalizedName
{
  return [self sectionEntryName];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"<%@ %p: name=%@>", [self className], self, name];
}

@end
