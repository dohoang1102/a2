//
//  AMApplicationDelegate.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMApplicationDelegate.h"
#import "AMDocumentController.h"


@implementation AMApplicationDelegate
@synthesize documentController;

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
  NSLog(@"%@ %s %@", [self className], _cmd, documentController);
}

@end
