//
//  AMSite.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMServer;

@interface AMSite : NSObject <NSCoding> {
  AMServer *server;
}

@property(nonatomic, readwrite, retain) AMServer *server;

@end
