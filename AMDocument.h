//
//  AMDocument.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "AMSetupAccountSheetController.h"


@class AMSite, AMDocumentWindowController;

@interface AMDocument : NSDocument <AMSetupAccountSheetControllerDelegate> {
  AMSite *site;
}

@property(nonatomic, readwrite, retain) AMSite *site;

- (void)didOpenUntitledDocument;

@end
