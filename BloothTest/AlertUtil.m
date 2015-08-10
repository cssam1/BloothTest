//
//  AlertUtil.m
//  iPadXHPortal
//
//  Created by ye huixiang on 12-8-31.
//  Copyright (c) 2012年 lenovo-cw. All rights reserved.
//

#import "AlertUtil.h"

@implementation AlertUtil

+ (void)showMsg:(NSString*)msg {
	UIAlertView *alt = [[UIAlertView alloc] 
						initWithTitle:@"温馨提示"
						message:msg
						delegate:nil
						cancelButtonTitle:@"确定"
						otherButtonTitles:nil];
	[alt show];
	//[alt release];
}

@end
