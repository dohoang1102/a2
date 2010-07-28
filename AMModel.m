//
//  AMModel.m
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMModel.h"
#import "AMDispatch.h"

@interface AMModel ()
@property(nonatomic, readwrite, retain) AMDispatch *dispatch;
@end

@implementation AMModel
@synthesize dispatch, key;

- (id)init
{
  return [self initWithDispatch:nil];
}

- (id)initWithDispatch:(AMDispatch *)aDispatch
{
  NSParameterAssert(aDispatch != nil);
  if(self = [super init]) {
    self.dispatch = aDispatch;
  }
  return self;
}

- (void)dealloc
{
  self.dispatch = nil;
  self.key = nil;
  [super dealloc];
}

@end
