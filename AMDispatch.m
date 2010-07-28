//
//  AMDispatch.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDispatch.h"
#import "AMTarget.h"


NSString *const AMDispatchDidBecomeBusyNotification = @"AMDispatchDidBecomeBusyNotification";
NSString *const AMDispatchDidBecomeIdleNotification = @"AMDispatchDidBecomeIdleNotification";


NSString *const AMDispatchErrorDomain = @"AMDispatchErrorDomain";

NSInteger const AMDispatchConnectionFailedErrorCode = 10;
NSInteger const AMDispatchInvalidJSONErrorCode = 11;
NSInteger const AMDispatchResponseStatusErrorCode = 12;


static void * AMDispatchContext = (void *) @"AMDispatchContext";

@interface AMDispatch ()
@property(nonatomic, readwrite, retain) NSURL *URL;
@property(nonatomic, readwrite, retain) NSMutableDictionary *connections;
@end

@implementation AMDispatch
@synthesize delegate, URL, baseURL, URLPrefix, defaultParameters, connections;

- (id)init
{
  if(self = [super init]) {
    connections = [[NSMutableDictionary alloc] init];
    [self addObserver:self forKeyPath:@"baseURL" options:NSKeyValueObservingOptionNew context:&AMDispatchContext];
    [self addObserver:self forKeyPath:@"URLPrefix" options:NSKeyValueObservingOptionNew context:&AMDispatchContext];
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"%@ %s", [self className], _cmd);
  
  [self removeObserver:self forKeyPath:@"baseURL"];
  [self removeObserver:self forKeyPath:@"URLPrefix"];

  [self cancelAllOperations];
  self.connections = nil;
  
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

- (NSDictionary *)mergeDefaultParameters:(NSDictionary *)parameters
{
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  if(defaultParameters) {
    [dict addEntriesFromDictionary:defaultParameters];
  }
  if(parameters) {
    [dict addEntriesFromDictionary:parameters];
  }
  return dict;
}

#pragma mark -

- (void)addConnection:(AMDispatchConnection *)connection
{
  NSLog(@"%@ %s %@", [self className], _cmd, connection.operationID);

  [connections setObject:connection forKey:connection.operationID];
  [connection start];
  
  if([connections count] == 1) {
    [[NSNotificationCenter defaultCenter] postNotificationName:AMDispatchDidBecomeBusyNotification object:self];    
  }
}

- (void)connectionDidFinish:(AMDispatchConnection *)connection
{
  NSLog(@"%@ %s %@", [self className], _cmd, connection.operationID);

  AMDispatchOperationID operationID = connection.operationID;
  [connections removeObjectForKey:operationID];
  
  if([connections count] == 0) {
    [[NSNotificationCenter defaultCenter] postNotificationName:AMDispatchDidBecomeIdleNotification 
                                                        object:self];    
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
  CFUUIDRef uuidRef = CFUUIDCreate(NULL);
  NSString *operationId = [(NSString *)CFUUIDCreateString(NULL, uuidRef) autorelease];
  CFRelease(uuidRef);
 
  AMTarget *connectionUserInfo =  [AMTarget targetWithObject:target 
                                                     success:success 
                                                      failed:failed 
                                                    userInfo:userInfo];
  
  AMDispatchConnection *connection;
  connection= [[AMDispatchConnection alloc] initWithOperationID:operationId
                                                            URL:url 
                                                     parameters:[self mergeDefaultParameters:parameters] 
                                                       userInfo:connectionUserInfo 
                                                       delegate:self];
  
  [self addConnection:connection];
  [connection release];
  
  return operationId;
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

- (void)cancelOperation:(AMDispatchOperationID)operationID
{
  NSLog(@"%@ %s %@", [self className], _cmd, operationID);
  AMDispatchConnection *connection = [connections objectForKey:operationID];
  if(connection) {    
    [connection cancel];
    [self connectionDidFinish:connection];
  }
}

- (void)cancelAllOperations
{
  NSLog(@"%@ %s", [self className], _cmd);
  for(AMDispatchOperationID operationID in [connections allKeys]) {
    [self cancelOperation:operationID];
  }  
}

#pragma mark -

- (void)dispatchConnection:(AMDispatchConnection *)connection didSucceedWithResult:(id)result
{
  [connection retain];
  [self connectionDidFinish:connection];
  
  AMTarget *target = [connection userInfo];
  [target.object performSelector:target.success withObject:result withObject:target.userInfo];
  [connection release];
}

- (void)dispatchConnection:(AMDispatchConnection *)connection didFailWithError:(NSError *)error
{
  NSUInteger retryCount = connection.retryCount;
  if(retryCount < 5) {
    [connection retry];
  } else {
    [connection retain];
    [self connectionDidFinish:connection];

    AMTarget *target = [connection userInfo];
    [target.object performSelector:target.failed withObject:error withObject:target.userInfo];
    [connection release];
  }
}

@end
