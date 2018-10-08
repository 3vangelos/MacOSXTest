#import <Cocoa/Cocoa.h>
#import "ColorHelper.h"

@implementation ColorHelper

+ (NSColor *)colorForIndex:(NSInteger)index maxIndex:(NSInteger)maxIndex {
    CGFloat value = 1.0/maxIndex;
    CGFloat hue = value * index;
    return [NSColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1];
}

@end
