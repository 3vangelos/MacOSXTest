//
//  Parser.m
//  Visualizer
//
//  Created by Evangelos Sismanidis on 03.10.18.
//  Copyright © 2018 Evangelos Sismanidis. All rights reserved.
//

#import "Parser.h"

@implementation Parser

+ (NSArray *) parseInData {
    NSString *fileContents = [self readInFile];
    NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString *line in lines) {
        NSMutableArray *oneLine = [[line componentsSeparatedByString:@","] mutableCopy];
        if (oneLine.count < 10) {
            continue;
        }
        
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)];
        [oneLine removeObjectsAtIndexes: indexes];
        [array addObject:oneLine];
    }
    
    [array removeObjectAtIndex:0];
    return [array copy];
}

+ (NSString *) readInFile {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"csv"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
    }
    
    return fileContents;
}

@end
