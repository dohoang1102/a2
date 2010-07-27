//
//  AMSnippet.h
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMModel.h"


@interface AMSnippet : AMModel {
  NSString *title;
  NSString *content;
}

@property(nonatomic, readwrite, copy) NSString *title;
@property(nonatomic, readwrite, copy) NSString *content;

- (id)initWithTitle:(NSString *)title;

@end
