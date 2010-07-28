//
//  AMSession.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMSession.h"
#import "AMTarget.h"
#import "AMDispatch.h"


@implementation AMSession
@synthesize busy, created, login, password;

- (void)dealloc
{
  self.login    = nil;
  self.password = nil;
  [super dealloc];
}

#pragma mark -

- (void)createWithTarget:(id)target success:(SEL)success failed:(SEL)failed
{
  if(!self.busy && !self.created) {
    self.busy = YES;
    if(![dispatch performOperationNamed:@"Logging in" 
                               withPath:@"/session/create" 
                             parameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                         self.login,    @"login",
                                         self.password, @"password",
                                         nil] 
                                 target:self 
                                success:@selector(didCreateWithResult:userInfo:) 
                                 failed:@selector(createDidFailWithError:userInfo:) 
                               userInfo:[AMTarget targetWithObject:target success:success failed:failed]]) {
      self.busy = NO;
    }
  }  
}

- (void)createWithURL:(NSString *)url target:(id)target success:(SEL)success failed:(SEL)failed
{
  if(!self.busy && !self.created) {
    if(!url) { return; }
    NSURL *URL = [NSURL URLWithString:url];
    if(!URL) { return; }
    [dispatch setBaseURL:URL];
    
    [self createWithTarget:target success:success failed:failed];
  }
}

- (void)didCreateWithResult:(NSDictionary *)result userInfo:(AMTarget *)target
{
  self.busy = NO;
  self.created = YES;
  self.key = [result objectForKey:@"key"];
  [target.object performSelector:target.success withObject:self];
}

- (void)createDidFailWithError:(NSError *)error userInfo:(AMTarget *)target
{
  self.busy = NO;
  self.created = NO;
  self.key = nil;
  [target.object performSelector:target.failed withObject:self withObject:error];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"<%@ %p: key=%@, login=%@, password=%@>", [self className], self, key, login, password];
}

@end
