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
@synthesize login, password;

- (void)dealloc
{
  self.login    = nil;
  self.password = nil;
  [super dealloc];
}

#pragma mark -

- (void)createWithTarget:(id)target success:(SEL)success failed:(SEL)failed
{
  [dispatch performOperationNamed:@"Logging in" 
                         withPath:@"/session/create" 
                       parameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                   self.login,    @"login",
                                   self.password, @"password",
                                   nil] 
                           target:self 
                          success:@selector(didCreateWithResult:userInfo:) 
                           failed:@selector(createDidFailWithError:userInfo:) 
                         userInfo:[AMTarget targetWithObject:target success:success failed:failed]];
}

- (void)didCreateWithResult:(NSDictionary *)result userInfo:(id)userInfo
{
  
}

- (void)createDidFailWithError:(NSError *)error userInfo:(id)userInfo
{
  
}

@end
