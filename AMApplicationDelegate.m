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
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
  NSArray *urls = [documentController recentDocumentURLs];
  if([urls count] > 0) {
    NSURL *url = [urls objectAtIndex:0];
    if([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
      NSError *error = nil;
      if([documentController openDocumentWithContentsOfURL:url display:YES error:&error]) {
        return NO;
      }
    }
  }
  return YES;
}

@end
