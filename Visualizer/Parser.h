//
//  Parser.h
//  Visualizer
//
//  Created by Evangelos Sismanidis on 03.10.18.
//  Copyright © 2018 Evangelos Sismanidis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Parser : NSObject

+ (NSArray *) parseInData;
+ (NSString *) readInFile;

@end

NS_ASSUME_NONNULL_END
