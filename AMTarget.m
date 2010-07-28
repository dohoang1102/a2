//
//  AMTarget.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMTarget.h"


@implementation AMTarget
@synthesize object, success, failed, userInfo;

+ (id)target
{
  return [[[self alloc] init] autorelease];
}

+ (id)targetWithObject:(id)object success:(SEL)success failed:(SEL)failed
{
  return [[[self alloc] initWithObject:object success:success failed:failed] autorelease];  
}

+ (id)targetWithObject:(id)object success:(SEL)success failed:(SEL)failed userInfo:(id)userInfo
{
  return [[[self alloc] initWithObject:object success:success failed:failed userInfo:userInfo] autorelease];
}

- (id)init
{
  return [self initWithObject:nil success:nil failed:nil userInfo:nil];
}

- (id)initWithObject:(id)anObject success:(SEL)aSuccess failed:(SEL)aFailed
{
  return [self initWithObject:anObject success:aSuccess failed:aFailed userInfo:nil];
}

- (id)initWithObject:(id)anObject success:(SEL)aSuccess failed:(SEL)aFailed userInfo:(id)anUserInfo
{
  if(self = [super init]) {
    self.object = anObject;
    self.success = aSuccess;
    self.failed = aFailed;
    self.userInfo = anUserInfo;
  }
  return self;
}

- (void)dealloc
{
  self.object = nil;
  self.userInfo = nil;
  [super dealloc];
}

@end
