//
//  AMSession.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMModel.h"

@interface AMSession : AMModel {
  BOOL busy;
  BOOL created;

  NSString *login;
  NSString *password;
}

@property(nonatomic, readwrite, getter=isBusy) BOOL busy;
@property(nonatomic, readwrite, getter=isCreated) BOOL created;

@property(nonatomic, readwrite, copy) NSString *login;
@property(nonatomic, readwrite, copy) NSString *password;

// -createDidSucceed:
// -createDidFail:withError:
- (void)createWithTarget:(id)target success:(SEL)success failed:(SEL)failed;

@end
