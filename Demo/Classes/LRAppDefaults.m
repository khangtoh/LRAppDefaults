//
//  LRAppDefaults.m
//
//  Created by Khang Toh on 9/14/2010.
//  Copyright 2010 LeftRight Studios. All rights reserved.
//


#import "LRAppDefaults.h"


static NSString *kLRAppDefaults = @"kLRAppDefaults";
static NSString *kLRAppDefaults_InstallDate = @"kLRAppDefaults_InstallDate";
static BOOL kLRAppDefaults_newInstall =  NO;

static LRAppDefaults *gAppDefaults=nil;

@implementation LRAppDefaults

+(void)initialize {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSData *testValue = [defaults objectForKey:kLRAppDefaults];
    	
	if (testValue == nil) 
	{
		NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDate date] forKey:kLRAppDefaults_InstallDate];
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
									 dict, kLRAppDefaults, nil];
		
		[defaults registerDefaults:appDefaults];
		[defaults setObject:dict forKey:kLRAppDefaults];
		[defaults synchronize];
		
		kLRAppDefaults_newInstall = YES;
	}
	else {
		kLRAppDefaults_newInstall = NO;
	}

}

+ (BOOL) isNewInstall {
	return kLRAppDefaults_newInstall;
}

+ (NSDate *) installDate {
	return [LRAppDefaults getAppSettingWithKey:kLRAppDefaults_InstallDate];
}

+ (void) createSharedInstance
{
	NSAssert(gAppDefaults == nil, @"Attempting to initialize gAppDefaults a second time.");
	gAppDefaults = [[LRAppDefaults alloc] init];
}

+ (void)destroySharedInstance
{
	NSAssert(gAppDefaults != nil, @"Attempting to shutdown gAppDefaults when not instantiated.");
	[gAppDefaults release];
	gAppDefaults = nil;
}

+ (LRAppDefaults*) sharedInstance
{
	@synchronized (self)
	{	if(gAppDefaults == nil) {
		[self createSharedInstance];
	}
	}
	return gAppDefaults;
}

+ (void)addAppSetting:(id)setting withKey:(NSString *)key {
	LRAppDefaults *d = [LRAppDefaults sharedInstance];
	[d createNewAppSetting:setting withKey:key];
	
}
+ (id)getAppSettingWithKey:(NSString *)key {
	LRAppDefaults *d = [LRAppDefaults sharedInstance];
	return [d getAppSettingWithKey:key];
	
}

+ (void)updateAppSetting:(id)setting withKey:(NSString *)key  {
	LRAppDefaults *d = [LRAppDefaults sharedInstance];
	if ([d getAppSettingWithKey:key]) {
		[d updateAppSetting:setting	withKey:key];
	}
}
- (void)dealloc {
	[super dealloc];
}

- (id)init {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ((self = [super init])) {
		appSettings = [[NSMutableDictionary alloc] initWithDictionary:
					   [defaults objectForKey:kLRAppDefaults]];
		
	}
	
	return self;
}


- (void)save {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:appSettings forKey:kLRAppDefaults];
	[defaults synchronize];
	
}


- (void)createNewAppSetting:(id)setting withKey:(NSString *)key {
	
	NSMutableDictionary *newAppSetting = [[NSMutableDictionary alloc] 
										  initWithObjectsAndKeys:setting,key,nil];
	
	[newAppSetting addEntriesFromDictionary:appSettings];
	
	[appSettings release];
	
	appSettings = [newAppSetting retain];
	
	[newAppSetting release];
	
	[self save];
	
}

- (id)getAppSettingWithKey:(NSString *)key {
	return [appSettings objectForKey:key];
}

- (void)updateAppSetting:(id)setting withKey:(NSString *)key {
	if ([appSettings objectForKey:key]) {
		[appSettings setObject:setting forKey:key];
		[self save];
	}
}


@end