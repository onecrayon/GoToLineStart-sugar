//
//  OCGoToLineStart.m
//  Go To Line Start
//
//  Created by Ian Beck on 11/29/11.
//  Copyright 2011 One Crayon. All rights reserved.
//

#import "OCGoToLineStart.h"
#import	<EspressoTextActions.h>
#import <EspressoTextCore.h>


@implementation OCGoToLineStart

@synthesize customModal;
@synthesize lineNumberField;

// These methods are the default Espresso action methods; don't need them to do anything in this case, though

- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (BOOL)canPerformActionWithContext:(id)context
{
	return YES;
}

// This is called when the action is invoked, so we load up our modal to kick things off

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	// Load in our modal window if we have not previously
	if (!customModal) {
		[NSBundle loadNibNamed:@"OCGoToLineStartWindow" owner:self];
	} else {
		// Reset the window values
		[lineNumberField setStringValue:@""];
	}
	
	// Save our context for later
	myContext = [context retain];
	
	// Display the modal dialog
	[NSApp runModalForWindow:customModal];
	
	// Buck's been passed to the sheet, so exit happily
	return YES;
}

- (void)dealloc
{
	MRRelease(myContext);
	[super dealloc];
}

// Act on a submitted window

- (IBAction) submitModal:(id)sender
{
	// Grab our line number
	NSUInteger lineNumber = (NSUInteger)[lineNumberField integerValue];
	// Close the window
	[customModal close];
	// Grab the range of the target line; this behaves pretty sanely when entering lines that exceed the document's range, so no need for error handling
	NSRange lineRange = [[myContext lineStorage] lineRangeForLineNumber:lineNumber];
	// Then set our cursor target location
	NSRange target = NSMakeRange(lineRange.location, 0);
	// Place the cursor
	[myContext setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:target]]];
}

// Delegate method for handling the window closing

- (void)windowWillClose:(NSNotification *)notification
{
	[NSApp stopModal];
}

// Delegate method for handling escape in the text field

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)command
{
	if (command == @selector(cancelOperation:)) {
		[customModal close];
	}
	return NO;
}

@end
