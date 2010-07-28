//
//  AMModel.h
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMDispatch;

@interface AMModel : NSObject {
  AMDispatch *dispatch;
  NSString *key;
}

- (id)initWithDispatch:(AMDispatch *)dispatch;

@property(nonatomic, readonly, retain) AMDispatch *dispatch;

@property(nonatomic, readwrite, copy) NSString *key;

@end
