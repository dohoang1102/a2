//
//  AMModel.h
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AMModel : NSObject {
  NSString *key;
}

@property(nonatomic, readwrite, copy) NSString *key;

@end
