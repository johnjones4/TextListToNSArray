//
//  StringToArrayListConverter.m
//  TextListToNSArray
//
//  Created by John Jones on 3/9/14.
//  Copyright (c) 2014 Phoenix4 LLC. All rights reserved.
//

#import "StringToArrayListConverter.h"

@interface StringToArrayListConverter()

- (void)_convert;

@end

@implementation StringToArrayListConverter

- (id)initWithInputDir:(NSString*)inputDir andOutputDir:(NSString*)outputDir {
    if (self = [super init]) {
        self.inputDir = inputDir;
        self.outputDir = outputDir;
    }
    return self;
}

- (void)convert {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("com.phoenix4.TextListToNSString", 0);
    dispatch_async(dispatchQueue, ^{
        [self _convert];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate converterComplete:self];
        });
    });
}

- (void)_convert {
    NSError* error1;
    NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.inputDir error:&error1];
    NSMutableArray* manifest = [[NSMutableArray alloc] initWithCapacity:files.count];
    if (files && !error1) {
        for(NSString* file in files) {
            if ([[file pathExtension] isEqualToString:@"txt"]) {
                NSString* path = [self.inputDir stringByAppendingPathComponent:file];
                NSData* fileData = [[NSData alloc] initWithContentsOfFile:path];
                if (fileData) {
                    NSString* fileText = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
                    if (fileText) {
                        NSArray* lines = [fileText componentsSeparatedByString:@"\n"];
                        NSSet* dedupe = [[NSSet alloc] initWithArray:lines];
                        NSArray* final = [dedupe allObjects];
                        NSString* name = [NSString stringWithFormat:@"%lu_%@.xml",(unsigned long)final.count,[file substringToIndex:[file rangeOfString:@"."].location]];
                        NSString* outputPath = [self.outputDir stringByAppendingPathComponent:name];
                        [final writeToFile:outputPath atomically:YES];
                        [manifest addObject:name];
                    }
                }
            }
        }
    }
    NSString* manifestFile = [self.outputDir stringByAppendingPathComponent:@"manfiest.xml"];
    [manifest writeToFile:manifestFile atomically:YES];
}

@end
