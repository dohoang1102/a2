//
//  AMSection+NSTreeController.h
//  a2
//
//  Created by ampatspell on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AMSectionNode
- (NSUInteger)countOfNodes;
- (id)objectInNodesAtIndex:(NSUInteger)index;
- (BOOL)isLeafNode;
- (NSString *)nodeLocalizedName;
@end
