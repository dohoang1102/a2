//
//  AMSection.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSection.h"


@interface AMSection ()
@property(nonatomic, readwrite, retain) NSMutableArray *models;
@end

@implementation AMSection
@synthesize models;

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
  if([key isEqualToString:@"sectionEntries"]) {
    return [NSSet setWithObject:@"models"];
  }
  return [super keyPathsForValuesAffectingValueForKey:key];
}

#pragma mark -

- (id)init
{
  if(self = [super init]) {
    models = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)dealloc
{
  self.models = nil;
  [super dealloc];
}

#pragma mark -

- (NSUInteger)countOfModels
{
  return [models count];
}
- (id)objectInModelsAtIndex:(NSUInteger)index
{
  return [models objectAtIndex:index];
}

- (NSArray *)modelsAtIndexes:(NSIndexSet *)indexes
{
  return [models objectsAtIndexes:indexes];
}

- (void)insertObject:(id)object inModelsAtIndex:(NSUInteger)index
{
  [models insertObject:object atIndex:index];
}

- (void)removeObjectFromModelsAtIndex:(NSUInteger)index
{
  [models removeObjectAtIndex:index];
}

- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withModels:(NSArray *)objects
{
  [models replaceObjectsAtIndexes:indexes withObjects:objects];
}

- (void)insertModels:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
  [models insertObjects:objects atIndexes:indexes];
}

- (void)removeModelsAtIndexes:(NSIndexSet *)indexes
{
  [models removeObjectsAtIndexes:indexes];
}

@end
