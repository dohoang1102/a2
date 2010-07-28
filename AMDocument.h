//
//  AMDocument.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "AMSetupAccountSheetController.h"
#import "AMDispatch.h"


@class AMSite, AMSession, AMDocumentWindowController;

@interface AMDocument : NSDocument <AMSetupAccountSheetControllerDelegate, AMDispatchDelegate> {
  AMDispatch *dispatch;
  AMSite *site;
  AMSession *session;
}

@property(nonatomic, readwrite, retain) AMSite *site;
@property(nonatomic, readwrite, retain) AMSession *session;
@property(nonatomic, readwrite, retain) AMDispatch *dispatch;

- (void)didOpenUntitledDocument;

@end
