//
//  AMDocument.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>


@class AMSite;

@interface AMDocument : NSDocument {
  AMSite *site;
}

@property(nonatomic, readwrite, retain) AMSite *site;

@end
