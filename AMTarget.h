//
//  AMTarget.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AMTarget : NSObject {
  id object;
  SEL success;
  SEL failed;
  id userInfo;
}

@property(nonatomic, readwrite, retain) id object;
@property(nonatomic, readwrite) SEL success;
@property(nonatomic, readwrite) SEL failed;
@property(nonatomic, readwrite, retain) id userInfo;

+ (id)target;
+ (id)targetWithObject:(id)object success:(SEL)success failed:(SEL)failed;
+ (id)targetWithObject:(id)object success:(SEL)success failed:(SEL)failed userInfo:(id)userInfo;

- (id)init;
- (id)initWithObject:(id)object success:(SEL)success failed:(SEL)failed;
- (id)initWithObject:(id)object success:(SEL)success failed:(SEL)failed userInfo:(id)userInfo;

@end
