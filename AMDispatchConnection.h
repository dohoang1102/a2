//
//  ZRRPCOperation.h
//  ZeroEdit
//
//  Created by ampatspell on 6/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol AMDispatchConnectionDelegate;

@interface AMDispatchConnection : NSObject {
  id operationID;
  id<AMDispatchConnectionDelegate> delegate;
  
  NSURL *url;
  NSDictionary *parameters;
  id userInfo;
  
  NSURLConnection *connection;
  NSMutableData *body;
  NSInteger status;
  
  BOOL cancelled;
  NSUInteger retryCount;
}

- (id)initWithOperationID:(id)operationID
                      URL:(NSURL *)anURL 
               parameters:(NSDictionary *)aParameters 
                 userInfo:(id)anUserInfo 
                 delegate:(id<AMDispatchConnectionDelegate>)aDelegate;

@property(nonatomic, readonly, copy) id operationID;
@property(nonatomic, readonly, retain) id userInfo;

@property(nonatomic, readonly) NSUInteger retryCount;

- (void)start;
- (void)cancel;

- (void)retry;

@end

@protocol AMDispatchConnectionDelegate
- (void)dispatchConnection:(AMDispatchConnection *)connection didSucceedWithResult:(id)result;
- (void)dispatchConnection:(AMDispatchConnection *)connection didFailWithError:(NSError *)error;
@end
