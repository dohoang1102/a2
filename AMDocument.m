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
#import "AMSession.h"
#import "AMServer.h"
#import "NSWindow+AMAdditions.h"


@interface AMDocument ()
@end

@implementation AMDocument
@synthesize site, session, dispatch;

- (id)init
{
  if(self = [super init]) {
    dispatch = [[AMDispatch alloc] init];
    dispatch.URLPrefix = @"/rpc";
    dispatch.delegate = self;
  }
  return self;
}

- (void)dealloc
{
  self.dispatch = nil;
  self.site = nil;
  self.session = nil;
  [super dealloc];
}

#pragma mark -

- (NSDictionary *)dispatch:(AMDispatch *)sender didReceiveResult:(NSDictionary *)result error:(NSError **)error
{
  NSString *status = [result objectForKey:@"status"];
  if([status isEqualToString:@"success"]) {
    return [result objectForKey:@"data"];
  } else {
    NSString *reason = [result objectForKey:@"reason"];
    if(!reason) {
      reason = @"Server didn't return reason";
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reason forKey:NSLocalizedDescriptionKey];
    *error = [NSError errorWithDomain:@"AMDispatchErrorDomain" code:101 userInfo:userInfo];
    return nil;
  }
}

#pragma mark -

- (void)showSetupAccountSheet
{
  site = [[AMSite alloc] init];
  [AMSetupAccountSheetController showSetupAccountSheetForWindow:[self windowForSheet] 
                                                      withModel:[site server] 
                                                       dispatch:dispatch
                                                       delegate:self];
}

- (void)setupAccountSheetDidEnd:(AMSetupAccountSheetController *)controller returnCode:(NSUInteger)code
{
  if(code == NSOKButton) {
    self.session = controller.session;
    [self updateChangeCount:NSChangeDone];
  } else if(code == NSCancelButton) {
    [self close];
  }
}

- (void)didOpenUntitledDocument
{
  [self showSetupAccountSheet];
}

#pragma mark -

- (void)performLogin
{
  [session createWithTarget:self success:@selector(didLogin:) failed:@selector(loginDidFail:withError:)];  
}

- (void)showLoginSheet
{
  // This will put modal sheet while fetching essential stuff. later.
  
  AMServer *server = site.server;
  
  dispatch.baseURL = [NSURL URLWithString:server.url];
  
  self.session = [[[AMSession alloc] initWithDispatch:dispatch] autorelease];
  session.login = server.login;
  session.password = server.password;
  [self performLogin];
}

- (void)didLogin:(AMSession *)sender
{
  NSLog(@"Logged in %@", sender.key);
}

- (void)loginDidFail:(AMSession *)session withError:(NSError *)error
{
  NSBeginAlertSheet(@"Login failed", 
                    @"Retry", 
                    @"Close", 
                    nil, 
                    [self windowForSheet], 
                    self, 
                    @selector(loginFailedSheetDidEnd:returnCode:contextInfo:), 
                    nil, 
                    nil, 
                    @"%@", 
                    [[error userInfo] valueForKey:NSLocalizedDescriptionKey]);
}

- (void)loginFailedSheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
  if(returnCode == NSOKButton) {
    // retry
    [self performLogin];
  } else {
    // close
    [self performSelector:@selector(close) withObject:nil afterDelay:.4f];
  }
}

#pragma mark -

- (void)makeWindowControllers
{
  AMDocumentWindowController *controller = [[AMDocumentWindowController alloc] init];
  [self addWindowController:controller];
  [controller release];
}

- (void)close
{
  [dispatch cancelAllOperations];
  [super close];
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
  [self showLoginSheet];
  return YES;
}

@end
