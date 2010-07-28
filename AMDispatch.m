//
//  AMDispatch.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDispatch.h"


static void * AMDispatchContext = (void *) @"AMDispatchContext";

@interface AMDispatch ()
@property(nonatomic, readwrite, retain) NSURL *URL;
@end

@implementation AMDispatch
@synthesize URL, baseURL, URLPrefix, defaultParameters;

- (id)init
{
  if(self = [super init]) {
    [self addObserver:self forKeyPath:@"baseURL" options:NSKeyValueObservingOptionNew context:&AMDispatchContext];
    [self addObserver:self forKeyPath:@"URLPrefix" options:NSKeyValueObservingOptionNew context:&AMDispatchContext];
  }
  return self;
}

- (void)dealloc
{
  [self removeObserver:self forKeyPath:@"baseURL"];
  [self removeObserver:self forKeyPath:@"URLPrefix"];
  self.URL = nil;
  self.baseURL = nil;
  self.URLPrefix = nil;
  self.defaultParameters = nil;
  [super dealloc];
}

#pragma mark -

- (void)updateURL
{
  if(baseURL && URLPrefix) {
    NSString *prefix;
    if([URLPrefix hasPrefix:@"/"]) {
      prefix = [URLPrefix substringFromIndex:1];
    } else {
      prefix = URLPrefix;
    }
    self.URL = [baseURL URLByAppendingPathComponent:prefix];
  } else {
    self.URL = nil;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if(context = &AMDispatchContext) {
    [self updateURL];
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark -

- (AMDispatchOperationID)performOperationNamed:(NSString *)name
                                       withURL:(NSURL *)url
                                    parameters:(NSDictionary *)parameters
                                        target:(id)target
                                       success:(SEL)success
                                        failed:(SEL)failed
                                      userInfo:(id)userInfo
{
  NSLog(@"%@", url);
  return nil;
}

- (AMDispatchOperationID)performOperationNamed:(NSString *)name 
                                      withPath:(NSString *)relativePath 
                                    parameters:(NSDictionary *)parameters 
                                        target:(id)target 
                                       success:(SEL)success 
                                        failed:(SEL)failed 
                                      userInfo:(id)userInfo
{
  if([relativePath hasPrefix:@"/"]) {
    relativePath = [relativePath substringFromIndex:1];
  }
  NSURL *absoluteURL = [URL URLByAppendingPathComponent:relativePath];
  return [self performOperationNamed:name 
                             withURL:absoluteURL 
                          parameters:parameters 
                              target:target 
                             success:success 
                              failed:failed 
                            userInfo:userInfo];
}

@end
