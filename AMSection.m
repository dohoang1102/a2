//
//  AMSection.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSection.h"


@implementation AMSection
@end

@implementation AMSection (AMSectionTreeNode)

- (NSUInteger)countOfNodes
{
  return [self countOfSectionEntries];
}

- (id)objectInNodesAtIndex:(NSUInteger)index
{
  return [self objectInSectionEntriesAtIndex:index];
}

- (BOOL)isLeafNode
{
  return NO;
}

- (NSString *)nodeLocalizedName
{
  return [self localizedName];
}

@end
