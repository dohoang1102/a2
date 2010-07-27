//
//  AMSnippet+AMSectionEntry.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSnippet+AMSectionEntry.h"


@implementation AMSnippet (AMSectionEntry)

- (NSString *)sectionEntryName
{
  return self.title;
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

@end
