//
//  AMSection+AMSectionNode.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSection+AMSectionNode.h"


@implementation AMSection (AMSectionNode)

+ (NSSet *)keyPathsForValuesAffectingNodes
{
  return [NSSet setWithObject:@"sectionEntries"];
}

- (NSUInteger)countOfNodes
{
  return [self countOfModels];
}

- (id)objectInNodesAtIndex:(NSUInteger)index
{
  return [self objectInModelsAtIndex:index];
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
