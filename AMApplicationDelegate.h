//
//  AMApplicationDelegate.h
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AMDocumentController;

@interface AMApplicationDelegate : NSObject <NSApplicationDelegate> {
  AMDocumentController *documentController;
}

@property(nonatomic, readwrite, assign) IBOutlet AMDocumentController *documentController;

@end
