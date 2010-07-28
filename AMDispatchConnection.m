//
//  ZRRPCOperation.m
//  ZeroEdit
//
//  Created by ampatspell on 6/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDispatchConnection.h"
#import "JSON.h"
#import "AMDispatch.h"


@interface AMDispatchConnection ()
@property(nonatomic, readwrite, copy) id operationID;
@property(nonatomic, readwrite, assign) id<AMDispatchConnectionDelegate> delegate;
@property(nonatomic, readwrite, copy) NSURL *url;
@property(nonatomic, readwrite, copy) NSDictionary *parameters;
@property(nonatomic, readwrite, retain) id userInfo;
@property(nonatomic, readwrite, getter=isCancelled) BOOL cancelled;
@property(nonatomic, readwrite, retain) NSURLConnection *connection;
@property(nonatomic, readwrite) NSInteger status;
@property(nonatomic, readwrite, retain) NSMutableData *body;
- (void)sendRequest;

- (void)requestDidSucceed;
- (void)requestDidFailWithErrorCode:(NSInteger)errorCode description:(NSString *)description;
- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description;
- (void)requestDidFailWithError:(NSError *)error;
- (void)requestDidFinish;

- (void)RPCDidSucceedWithJSON:(id)json;
- (void)RPCDidFailWithError:(NSError *)error;
@end

@implementation AMDispatchConnection
@synthesize operationID, delegate, url, parameters, connection, body, userInfo, status, cancelled, retryCount;

- (id)init
{
  return [self initWithOperationID:nil URL:nil parameters:nil userInfo:nil delegate:nil];
}

- (id)initWithOperationID:(id)anOperationID
                      URL:(NSURL *)anURL 
               parameters:(NSDictionary *)aParameters 
                 userInfo:(id)anUserInfo 
                 delegate:(id<AMDispatchConnectionDelegate>)aDelegate
{
  NSParameterAssert(anOperationID != nil);
  NSParameterAssert(anURL != nil);
  NSParameterAssert(aDelegate != nil);
  if(self = [super init]) {
    NSLog(@"%@ %s", [self className], _cmd);
    self.operationID = anOperationID;
    self.url = anURL;
    self.parameters = aParameters;
    self.userInfo = anUserInfo;
    self.delegate = aDelegate;
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"%@ %s", [self className], _cmd);
  self.operationID = nil;
  self.delegate = nil;
  self.url = nil;
  self.parameters = nil;
  self.userInfo = nil;
  self.connection = nil;
  self.body = nil;
  [super dealloc];
}

#pragma mark -

- (void)start
{
  [self sendRequest];
}

- (void)cancel
{
  self.cancelled = YES;
}

- (void)retry
{
  retryCount++;
  [self sendRequest];
}

#pragma mark -

- (void)sendRequest
{
  NSLog(@"AMDispatch • %@%@\n%@", self.url, (retryCount > 0 ? @" (Retry)" : @""), self.parameters);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
  [request setCachePolicy:NSURLCacheStorageNotAllowed];
  [request setHTTPMethod:@"POST"];
  if(parameters) {
    [request setHTTPBody:[[parameters JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]];
  }
  self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -

- (void)requestDidSucceed
{
  NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
  id json = [bodyString JSONValue];
  if(json) {
    [self RPCDidSucceedWithJSON:json];
  } else {
    [self RPCDidFailWithError:[self errorWithCode:AMDispatchInvalidJSONErrorCode 
                                      description:@"Server returned invalid JSON string"]];
  }
  [self requestDidFinish];
  [bodyString release];
}

- (void)requestDidFailWithErrorCode:(NSInteger)errorCode description:(NSString *)description
{
  [self requestDidFailWithError:[self errorWithCode:errorCode description:description]];
}

- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description
{
  NSDictionary *dict = [NSDictionary dictionaryWithObject:description 
                                                   forKey:NSLocalizedDescriptionKey];
  return [NSError errorWithDomain:AMDispatchErrorDomain code:code userInfo:dict];
}

- (void)requestDidFailWithError:(NSError *)error
{
  [self RPCDidFailWithError:error];
  [self requestDidFinish];   
}

- (void)requestDidFinish
{
  self.status     = 0;
  self.connection = nil;
  self.body       = nil;
}

#pragma mark -

- (void)RPCDidSucceedWithJSON:(id)json
{
  if(cancelled) {
    return;
  }
  [delegate dispatchConnection:self didSucceedWithResult:json];
}

- (void)RPCDidFailWithError:(NSError *)error
{
  if(cancelled) {
    return;
  }  
  [delegate dispatchConnection:self didFailWithError:error];
}

#pragma mark -

- (NSURLRequest *)connection:(NSURLConnection *)connection 
             willSendRequest:(NSURLRequest *)request 
            redirectResponse:(NSURLResponse *)response
{
  return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  if([response isKindOfClass:[NSHTTPURLResponse class]]) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.status = [httpResponse statusCode];
    self.body = [[[NSMutableData alloc] init] autorelease];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  [self.body appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  if(status == 200) {
    [self requestDidSucceed];
  } else {
    [self requestDidFailWithErrorCode:AMDispatchConnectionFailedErrorCode 
                          description:@"Server returned non 200 status code"];
  }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  [self requestDidFailWithErrorCode:AMDispatchResponseStatusErrorCode 
                        description:@"Cannot connect to server"];
}

@end
