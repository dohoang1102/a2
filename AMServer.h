//
//  AMServer.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AMServer : NSObject <NSCoding> {
  NSString *url;
  NSString *login;
  NSString *password;
}

@property(nonatomic, readwrite, copy) NSString *url;
@property(nonatomic, readwrite, copy) NSString *login;
@property(nonatomic, readwrite, copy) NSString *password;

@end
