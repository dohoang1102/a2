//
//  AMDispatch.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMDispatchConnection.h"


extern NSString *const AMDispatchDidBecomeBusyNotification;
extern NSString *const AMDispatchDidBecomeIdleNotification;


extern NSString *const AMDispatchErrorDomain;

extern NSInteger const AMDispatchConnectionFailedErrorCode;
extern NSInteger const AMDispatchInvalidJSONErrorCode;
extern NSInteger const AMDispatchResponseStatusErrorCode;


typedef NSString *AMDispatchOperationID;


@protocol AMDispatchDelegate;

@interface AMDispatch : NSObject <AMDispatchConnectionDelegate> {
  id<AMDispatchDelegate> delegate;
  NSURL *URL;
  NSURL *baseURL;
  NSString *URLPrefix;
  NSDictionary *defaultParameters;
  
  NSMutableDictionary *connections;
}

@property(nonatomic, readwrite, assign) id<AMDispatchDelegate> delegate;

@property(nonatomic, readonly, retain) NSURL *URL;
@property(nonatomic, readwrite, copy) NSURL *baseURL;
@property(nonatomic, readwrite, copy) NSString *URLPrefix;
@property(nonatomic, readwrite, retain) NSDictionary *defaultParameters;


// -(void)operationDidSucceedWithResult:(id)result userInfo:(id)userInfo;
// -(void)operationDidFailWithError:(NSError *)error userInfo(id)userInfo;

- (AMDispatchOperationID)performOperationNamed:(NSString *)name
                                       withURL:(NSURL *)url
                                    parameters:(NSDictionary *)parameters
                                        target:(id)target
                                       success:(SEL)success
                                        failed:(SEL)failed
                                      userInfo:(id)userInfo;

- (AMDispatchOperationID)performOperationNamed:(NSString *)name
                                      withPath:(NSString *)relativePath
                                    parameters:(NSDictionary *)parameters
                                        target:(id)target
                                       success:(SEL)success
                                        failed:(SEL)failed
                                      userInfo:(id)userInfo;

- (void)cancelOperation:(AMDispatchOperationID)operation;
- (void)cancelAllOperations;

@end

@protocol AMDispatchDelegate
// return modified dictionary if result is successful, otherwise nil and fill NSError
- (NSDictionary *)dispatch:(AMDispatch *)sender didReceiveResult:(NSDictionary *)result error:(NSError **)error;
@end