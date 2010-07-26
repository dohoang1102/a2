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


@implementation AMDocument
@synthesize site;

- (id)init
{
  self = [super init];
  if (self) {
    site = [[AMSite alloc] init];
  }
  return self;
}

- (void)makeWindowControllers
{
  AMDocumentWindowController *controller = [[AMDocumentWindowController alloc] init];
  [self addWindowController:controller];
  [controller release];
}

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
