//
//  AppDelegate.h
//  TextListToNSArray
//
//  Created by John Jones on 3/9/14.
//  Copyright (c) 2014 Phoenix4 LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StringToArrayListConverter.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,StringToArrayListConverterDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *inputPathTextField;
@property (weak) IBOutlet NSTextField *outputPathTextField;
@property (weak) IBOutlet NSProgressIndicator *progressBar;

- (IBAction)inputBrowseButtonSelected:(id)sender;
- (IBAction)outputBrowseButtonSelected:(id)sender;
- (IBAction)startButtonSelected:(id)sender;

@end
