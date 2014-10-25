//
//  AppGroup.m
//  FlickSKK
//
//  Created by BAN Jun on 2014/10/26.
//  Copyright (c) 2014年 BAN Jun. All rights reserved.
//

#import "AppGroup.h"

#define STR(x) @#x
#define STR2(x) STR(x)
static NSString * const kDeveloperName = STR2(USER);

@implementation AppGroup

+ (NSString *)appGroupID
{
    return [NSString stringWithFormat:@"group.org.codefirst.skk.%@.FlickSKK", kDeveloperName];
}

+ (NSString *)pathForResource:(NSString *)subpath
{
    NSString *containerPath = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:[self appGroupID]].path;
    return [containerPath stringByAppendingPathComponent:subpath];
}

@end