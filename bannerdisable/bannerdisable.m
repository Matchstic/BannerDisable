//
//  bannerdisable.m
//  bannerdisable
//
//  Created by Matt Clarke on 23/11/2012.
//  Copyright (c) 2012 matchstick. All rights reserved.
//

// SBSettings by BigBoss
// see http://thebigboss.org/guides-iphone-ipod-ipad/sbsettings-toggle-spec

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <notify.h>

static BOOL isToggleEnabled;

BOOL isCapable() // required; called when loaded; indicates if toggle supports current platform
{
	return YES;
}

BOOL isEnabled() // required; called when refresh button is pressed; functionally determines and indicates if toggle is on
{
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist"];
	BOOL isToggleEnabled = [[plistDict objectForKey:@"BannerDisableNotDisturb"] boolValue];
	
	return isToggleEnabled;
}

void setState(BOOL enable) // required; called when user presses toggle button
{
	NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist"];
	if (isToggleEnabled == NO)
	{
		[plistDict setValue:[NSNumber numberWithBool:YES] forKey:@"BannerDisableNotDisturb"];
		[plistDict writeToFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist" atomically: YES];
	}
	else if (isToggleEnabled == YES)
	{
		[plistDict setValue:[NSNumber numberWithBool:NO] forKey:@"BannerDisableNotDisturb"];
		[plistDict writeToFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist" atomically: YES];
	}
	notify_post("com.apple.springboard/Prefs");
}

float getDelayTime() // required; time in seconds spinner will show on toggle button after setState() returns (to allow background work to perform)
{
	return 0.6f;
}

BOOL allowInCall() // optional, if not implemented, assumed to return YES; indicates if toggle can be used during a call
{
	return NO;
}
