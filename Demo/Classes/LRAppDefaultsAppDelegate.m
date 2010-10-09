//
//  LRAppDefaultsAppDelegate.m
//  LRAppDefaults
//
//  Created by Alfred Toh on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LRAppDefaultsAppDelegate.h"
#import "LRAppDefaults.h"

@implementation LRAppDefaultsAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	NSLog(@"isNewInstall %d",[LRAppDefaults isNewInstall]);
	NSLog(@"systemVersion %@",[UIDevice currentDevice].systemVersion);

	if ([LRAppDefaults isNewInstall]) {
		//Any Foundation classes that serializes can be added and read later
		[LRAppDefaults addAppSetting:[NSNumber numberWithInt:0] withKey:@"is_updated"];
		NSArray *someArray = [NSArray arrayWithObjects:@"smackBOTS",@"rocks",nil];
		[LRAppDefaults addAppSetting:someArray withKey:@"what_app"];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
		label.font = [UIFont fontWithName:@"Helvetica" size:14];
		label.textColor = [UIColor blackColor];
		label.textAlignment = UITextAlignmentCenter;
		label.text = @"See this at first install and never again";
		[window addSubview:label];
		[label release];
		
		UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
		dateLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
		dateLabel.textColor = [UIColor blackColor];
		dateLabel.textAlignment = UITextAlignmentCenter;
		dateLabel.text = [NSString stringWithFormat:@"Install date %@",[LRAppDefaults installDate]];
		[window addSubview:dateLabel];
		[dateLabel release];
		
	}
	else {
		NSLog(@"is_updated %@",[LRAppDefaults getAppSettingWithKey:@"is_updated"]);
		NSLog(@"what_app %@",[LRAppDefaults getAppSettingWithKey:@"what_app"]);
		
		UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
		dateLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
		dateLabel.textColor = [UIColor blackColor];
		dateLabel.textAlignment = UITextAlignmentCenter;
		dateLabel.text = [NSString stringWithFormat:@"Install date %@",[LRAppDefaults installDate]];
		[window addSubview:dateLabel];
		[dateLabel release];
		
	}
	
	
	
    // Override point for customization after application launch.
    
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
