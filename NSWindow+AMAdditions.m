//
//  NSWindow+AMAdditions.m
//  Say
//
//  Created by ampatspell on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSWindow+AMAdditions.h"


@implementation NSWindow (AMAdditions)

- (BOOL)endEditing
{
  id responder = [self firstResponder];
  
  if (responder && [responder isKindOfClass:[NSTextView class]] && [(NSTextView*)responder isFieldEditor]) {
    responder = ([[responder delegate] isKindOfClass:[NSResponder class]]) ? [responder delegate] : nil;
  }
  
  BOOL success = [self makeFirstResponder:nil];
  
  if (success && responder != nil) {
    [self makeFirstResponder:responder];    
  }
  
  return success;  
}

- (void)makeInitialFirstResponderFirstResponder
{
  NSView *responder = [self initialFirstResponder];
  if(responder) {
    [self makeFirstResponder:responder];
  }  
}

- (void)showAlertSheetWithTitle:(NSString *)title forError:(NSError *)error
{
  NSString *message = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
  NSBeginAlertSheet(title, @"Done", nil, nil, self, nil, nil, nil, nil, @"%@", message);
}

@end
