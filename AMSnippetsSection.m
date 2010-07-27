//
//  AMSnippetsSection.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSnippetsSection.h"
#import "AMSnippet.h"


@interface AMSnippetsSection ()
@property(nonatomic, readwrite, retain) NSMutableArray *snippets;
@end

@implementation AMSnippetsSection
@synthesize snippets;

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
  if([key isEqualToString:@"nodes"]) {
    return [NSSet setWithObject:@"sectionEntries"];
  }
  return [super keyPathsForValuesAffectingValueForKey:key];
}

- (id)init
{
  if(self = [super init]) {
    snippets = [[NSMutableArray alloc] initWithObjects:
                [[[AMSnippet alloc] initWithTitle:@"Foo"] autorelease], 
                [[[AMSnippet alloc] initWithTitle:@"Bar"] autorelease], 
                [[[AMSnippet alloc] initWithTitle:@"Baz"] autorelease], 
                nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
  }
  return self;
}

- (void)timerDidFire:(NSTimer *)timer
{
  NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:[snippets count]];
  [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"sectionEntries"];
  [snippets addObject:[[[AMSnippet alloc] initWithTitle:[NSString stringWithFormat:@"%@", [NSDate date]]] autorelease]];
  [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"sectionEntries"];
}

- (void)dealloc
{
  self.snippets = nil;
  [super dealloc];
}

- (NSString *)localizedName
{
  return @"Code Snippets";
}

- (NSUInteger)countOfSectionEntries
{
  return [snippets count];
}

- (id<AMSectionEntry>)objectInSectionEntriesAtIndex:(NSUInteger)index
{
  return [snippets objectAtIndex:index];
}

- (NSUInteger)indexOfSectionEntry:(id<AMSectionEntry>)entry
{
  return [snippets indexOfObject:entry];
}

@end
