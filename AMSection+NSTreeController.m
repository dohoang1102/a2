//
//  AMSection+NSTreeController.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSection+NSTreeController.h"


@implementation AMSection (AMSectionTreeSupport)

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
  return [[self localizedName] uppercaseString];
}

@end
