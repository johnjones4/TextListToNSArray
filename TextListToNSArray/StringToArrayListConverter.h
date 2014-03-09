//
//  StringToArrayListConverter.h
//  TextListToNSArray
//
//  Created by John Jones on 3/9/14.
//  Copyright (c) 2014 Phoenix4 LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StringToArrayListConverter;

@protocol StringToArrayListConverterDelegate

- (void)converterComplete:(StringToArrayListConverter*)converter;

@end

@interface StringToArrayListConverter : NSObject

@property (nonatomic) NSString* inputDir;
@property (nonatomic) NSString* outputDir;
@property (nonatomic) id<StringToArrayListConverterDelegate> delegate;

- (id)initWithInputDir:(NSString*)inputDir andOutputDir:(NSString*)outputDir;
- (void)convert;

@end
