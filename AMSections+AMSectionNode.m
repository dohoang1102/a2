//
//  AMSections+AMSectionNode.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSections+AMSectionNode.h"


@implementation AMSections (AMSectionNode)

- (NSUInteger)countOfNodes
{
  return [self countOfSections];
}

- (id)objectInNodesAtIndex:(NSUInteger)index
{
  return [self objectInSectionsAtIndex:index];
}

- (BOOL)isLeafNode
{
  return NO;
}

- (NSString *)nodeLocalizedName
{
  return nil;
}

@end
