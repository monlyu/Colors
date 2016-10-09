//
//  VIColorFiled.h
//  Colors
//
//  Created by mk on 14-1-6.
//  Copyright (c) 2014年 Vnidev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VIColorFiled : NSView <NSControlTextEditingDelegate>

@property(nonatomic,strong) NSColorWell *well;
@property(nonatomic,strong) NSButton *hexColor;

-(void)setColorBackToWell:(NSString *)colorHex;

@end
