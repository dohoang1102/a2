//
//  NSWindow+AMAdditions.h
//  Say
//
//  Created by ampatspell on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSWindow (AMAdditions)

- (BOOL)endEditing;
- (void)makeInitialFirstResponderFirstResponder;


// - (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
- (void)showAlertSheetWithTitle:(NSString *)title 
                       forError:(NSError *)error 
                       delegate:(id)modalDelegate 
                 didEndSelector:(SEL)didEndSelector;

- (void)showAlertSheetWithTitle:(NSString *)title forError:(NSError *)error;

@end
