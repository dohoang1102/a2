//
//  AMDocument.m
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDocument.h"
#import "AMDocumentWindowController.h"
#import "AMSite.h"


@interface AMDocument ()
@end

@implementation AMDocument
@synthesize site;

- (void)dealloc
{
  self.site = nil;
  [super dealloc];
}

#pragma mark -

- (void)showSetupAccountSheet
{
  [AMSetupAccountSheetController showSetupAccountSheetForWindow:[self windowForSheet] 
                                                      withModel:[[self site] server] 
                                                       delegate:self];
}

- (void)setupAccountSheetDidEnd:(AMSetupAccountSheetController *)controller returnCode:(NSUInteger)code
{
  if(code == NSOKButton) {
    [self updateChangeCount:NSChangeDone];
  } else if(code == NSCancelButton) {
    [self close];
  }
}

#pragma mark -

- (void)didOpenUntitledDocument
{
  [self showSetupAccountSheet];
}

#pragma mark -

- (void)makeWindowControllers
{
  AMDocumentWindowController *controller = [[AMDocumentWindowController alloc] init];
  [self addWindowController:controller];
  [controller release];
}

#pragma mark -

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
  [super windowControllerDidLoadNib:aController];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
  NSMutableData *data = [[NSMutableData alloc] init];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver setOutputFormat:NSPropertyListXMLFormat_v1_0];
  [archiver encodeObject:site forKey:@"site"];
  [archiver finishEncoding];
  [archiver release];
  return [data autorelease];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  self.site = [unarchiver decodeObjectForKey:@"site"];
  [unarchiver release];
  return YES;
}

@end
