//
//  VIAppDelegate.m
//  Colors
//
//  Created by mk on 14-1-6.
//  Copyright (c) 2014年 Vnidev. All rights reserved.
//

#import "VIAppDelegate.h"


@implementation VIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{

    return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames
{

}

- (IBAction)save:(id)sender {

    NSArray *sub = [self.window.contentView subviews];
    NSBox *index1 = [sub objectAtIndex:1];
    NSArray *subviews = [index1.contentView subviews];
    NSMutableDictionary *mutable = [NSMutableDictionary dictionary];
    for (int i=0; i<subviews.count; i++) {
        VIColorFiled *f = (VIColorFiled*)[subviews objectAtIndex:i];
        [mutable setValue:f.hexColor.title forKey:[NSString stringWithFormat:@"%d",i]];
    }

    NSSavePanel *save = [NSSavePanel savePanel];
    [save setShowsTagField:NO];
    [save setAllowedFileTypes:@[@"cpc"]];
    
    if ([save runModal] == NSOKButton) {
        [mutable writeToURL:[save URL] atomically:YES];
    }
    
    
}

- (IBAction)load:(id)sender {
    
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanChooseDirectories:NO];

    if ([openDlg runModal] == NSOKButton )
    {

        NSArray* files = [openDlg URLs];
        for( int i = 0; i < [files count]; i++ ) {
            NSURL* fileName = [files objectAtIndex:i];
            [self loadFileBackTo:fileName];
        }
    }
}

-(void)loadFileBackTo:(NSURL *)fileName
{
    NSDictionary *dictwith = [[NSDictionary alloc] initWithContentsOfURL:fileName];
    
    NSArray *sub = [self.window.contentView subviews];
    NSBox *index1 = [sub objectAtIndex:1];
    NSArray *subviews = [index1.contentView subviews];
        for (int i=0; i<subviews.count; i++) {
            VIColorFiled *f = (VIColorFiled*)[subviews objectAtIndex:i];
            NSString *hexColor = [dictwith objectForKey:[NSString stringWithFormat:@"%d",i]];
            [f.hexColor setTitle:hexColor];
            [f setColorBackToWell:hexColor];
        }
}

@end
