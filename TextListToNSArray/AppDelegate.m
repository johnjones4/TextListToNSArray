//
//  AppDelegate.m
//  TextListToNSArray
//
//  Created by John Jones on 3/9/14.
//  Copyright (c) 2014 Phoenix4 LLC. All rights reserved.
//

#import "AppDelegate.h"

static NSString* kPrefInputDir = @"inputDir";
static NSString* kPrefOutputDir = @"outputDir";


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSDictionary* defaults = @{kPrefInputDir:@"",kPrefOutputDir:@""};
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    
    self.inputPathTextField.stringValue = [[NSUserDefaults standardUserDefaults] stringForKey:kPrefInputDir];
    self.outputPathTextField.stringValue = [[NSUserDefaults standardUserDefaults] stringForKey:kPrefOutputDir];
}

- (IBAction)inputBrowseButtonSelected:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    [panel beginWithCompletionHandler:^(NSInteger result) {
        self.inputPathTextField.stringValue = panel.directoryURL.path;
        [[NSUserDefaults standardUserDefaults] setObject:panel.directoryURL.path forKey:kPrefInputDir];
    }];
}

- (IBAction)outputBrowseButtonSelected:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    panel.canCreateDirectories = YES;
    [panel beginWithCompletionHandler:^(NSInteger result) {
        self.outputPathTextField.stringValue = panel.directoryURL.path;
        [[NSUserDefaults standardUserDefaults] setObject:panel.directoryURL.path forKey:kPrefOutputDir];
    }];
}

- (IBAction)startButtonSelected:(id)sender {
    StringToArrayListConverter* converter = [[StringToArrayListConverter alloc] initWithInputDir:self.inputPathTextField.stringValue andOutputDir:self.outputPathTextField.stringValue];
    converter.delegate = self;
    [self.progressBar startAnimation:self];
    [converter convert];
}

- (void)converterComplete:(StringToArrayListConverter *)converter {
    [self.progressBar stopAnimation:self];
}

@end