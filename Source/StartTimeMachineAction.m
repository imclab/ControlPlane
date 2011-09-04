//
//	StartTimeMachineAction.m
//	ControlPlane
//
//	Created by David Jennes on 02/09/11.
//	Copyright 2011. All rights reserved.
//

#import "StartTimeMachineAction.h"

@implementation StartTimeMachineAction


- (NSString *) description {
	if (turnOn)
		return NSLocalizedString(@"Starting Time Machine backup.", @"");
	else
		return NSLocalizedString(@"Stopping Time Machine backup.", @"");
}

- (BOOL) execute: (NSString **) errorString {
	NSString *command = turnOn ? @kCPHelperToolStartBackupTMCommand : @kCPHelperToolStopBackupTMCommand;
	
	// perform command on the mainthread because of the dangers of presenting NSAlert on a 
    // separate thread
    [self performSelectorOnMainThread: @selector(helperPerformAction:) withObject: command waitUntilDone: YES];
    
	if (error) {
		if (turnOn)
			*errorString = NSLocalizedString(@"Failed starting Time Machine backup.", @"");
		else
			*errorString = NSLocalizedString(@"Failed stopping Time Machine backup.", @"");
	}
	
	return (error ? NO : YES);
}

+ (NSString *) helpText {
	return NSLocalizedString(@"The parameter for StartTimeMachine actions is either \"1\" "
							 "or \"0\", depending on whether you want start or stop a "
							 "Time Machine backup.", @"");
}

+ (NSString *) creationHelpText {
	return @"Start or stop a Time Machine backup?";
}

+ (NSArray *) limitedOptions {
	return [NSArray arrayWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool: YES], @"option",
			 NSLocalizedString(@"Start backup", @""), @"description", nil],
			[NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool: NO], @"option",
			 NSLocalizedString(@"Stop backup", @""), @"description", nil],
			nil];
}

@end