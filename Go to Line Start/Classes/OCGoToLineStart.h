//
//  OCGoToLineStart.h
//  Go To Line Start
//
//  Created by Ian Beck on 11/29/11.
//  Copyright 2011 One Crayon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OCGoToLineStart : NSObject {
@private
    NSWindow *customModal;
	NSTextField *lineNumberField;
	
	id myContext;
}

@property (retain) IBOutlet NSWindow *customModal;
@property (retain) IBOutlet NSTextField *lineNumberField;

- (IBAction) submitModal:(id)sender;

// Delegate methods
- (void)windowWillClose:(NSNotification *)notification;
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)command;

@end
