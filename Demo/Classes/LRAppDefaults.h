//
//  LRAppDefaults.h
//
//  Created by Khang Toh on 9/14/2010.
//  Copyright 2010 LeftRight Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LRAppDefaults : NSObject {
	NSMutableDictionary *appSettings;
}


+ (BOOL) isNewInstall;
+ (NSDate *)installDate;
+ (void)addAppSetting:(id)setting withKey:(NSString *)key;
+ (id)getAppSettingWithKey:(NSString *)key;
+ (void)updateAppSetting:(id)setting withKey:(NSString *)key;
- (void)createNewAppSetting:(id)setting withKey:(NSString *)key;
- (id)getAppSettingWithKey:(NSString *)key;
- (void)updateAppSetting:(id)setting withKey:(NSString *)key;

@end
