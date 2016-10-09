//
//  VIColorFiled.m
//  Colors
//
//  Created by mk on 14-1-6.
//  Copyright (c) 2014年 Vnidev. All rights reserved.
//

#import "VIColorFiled.h"

@implementation VIColorFiled

-(void)setColorBackToWell:(NSString *)hex
{
    if ([hex characterAtIndex:0] == '#') {
        hex = [hex substringFromIndex:1];
    }
    NSString *rs = [hex substringWithRange:NSMakeRange(0, 2)];
    long r = strtol([rs UTF8String], NULL, 16);
    NSString *gs = [hex substringWithRange:NSMakeRange(2, 2)];
    long g = strtol([gs UTF8String], NULL, 16);
    NSString *bs = [hex substringWithRange:NSMakeRange(4, 2)];
    long b = strtol([bs UTF8String], NULL, 16);
    [self.well setColor:[NSColor colorWithCalibratedRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]];
}

-(id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
    
        self.well = [[NSColorWell alloc] initWithFrame:CGRectMake(1, 1, frameRect.size.width * 0.25, frameRect.size.height-2)];
        [self.well setTarget:self];
        [self.well setAction:@selector(afterSelected:)];
        [self.well setColor:[NSColor whiteColor]];
        [self addSubview:self.well];

        self.hexColor =  [[NSButton alloc] initWithFrame:CGRectMake(self.well.frame.origin.x+self.well.frame.size.width, 1, frameRect.size.width * 0.75 - 2, frameRect.size.height-2)];
        [self.hexColor setTitle:@"#FFFFFF"];
        self.hexColor.font = [NSFont fontWithName:@"monaco" size:13];
        self.hexColor.alignment = NSCenterTextAlignment;
        [self.hexColor setTarget:self];
        [self.hexColor setAction:@selector(doCopy:)];
        [self addSubview:self.hexColor];
    }
    return self;
}

-(void)doCopy:(NSButton *)btn
{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    NSArray *objectsToCopy = @[btn.title];
    NSString *hexColor = btn.title;
    BOOL OK = [pasteboard writeObjects:objectsToCopy];
    if(OK)
        [btn setTitle:@"Copyed"];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)( .5 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [btn setTitle:hexColor];
    });
}


-(void)afterSelected:(NSColorWell *)well
{
    double red = 0,blue = 0,green = 0,alpha = 0;
    [well.color getRed:&red green:&green blue:&blue alpha:&alpha];
    NSMutableString *hex = [NSMutableString stringWithString:@"#"];
    int redInt = red * 255;
    NSString *redString = [NSString stringWithFormat:@"%x",redInt];
    redString.length == 1 ? [hex appendFormat:@"0%@",redString] : [hex appendString:redString];
    
    int greenInt = green * 255;
    NSString *greenString = [NSString stringWithFormat:@"%x",greenInt];
    greenString.length == 1 ? [hex appendFormat:@"0%@",greenString] : [hex appendString:greenString];
    
    int blueInt = blue * 255;
    NSString *blueString = [NSString stringWithFormat:@"%x",blueInt];
    blueString.length == 1 ? [hex appendFormat:@"0%@",blueString] : [hex appendString:blueString];
    
    [self.hexColor setTitle:[hex uppercaseString]];
   // NSLog(@"%@",[hex uppercaseString]);
}

@end
