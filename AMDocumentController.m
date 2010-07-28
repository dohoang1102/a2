//
//  AMDocumentController.m
//  a2
//
//  Created by ampatspell on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AMDocumentController.h"
#import "AMDocument.h"


@implementation AMDocumentController

- (id)openUntitledDocumentAndDisplay:(BOOL)displayDocument error:(NSError **)outError
{
  AMDocument *document = [super openUntitledDocumentAndDisplay:displayDocument error:outError];
  [document didOpenUntitledDocument];
  return document;
}

- (NSUInteger)maximumRecentDocumentCount
{
  return 10;
}

@end
