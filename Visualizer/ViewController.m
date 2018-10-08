#import "ViewController.h"
#import "ColorHelper.h"
#import "Parser.h"

@interface ViewController()<NSWindowDelegate>

@property (strong, nonatomic) NSArray *lines;
@property (strong, nonatomic) NSArray *layers;

@end

@implementation ViewController

#pragma mark - Init Methods

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.lines = [Parser parseInData];
    }
    return self;
}

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.layers = [self createLayersFromLines:self.lines];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    [[self view] window].delegate = self;
}

- (void)viewDidDisappear {
    [[self view] window].delegate = nil;
    [super viewDidDisappear];
}


#pragma mark - NSWindow Delegate

- (void)windowDidResize:(NSNotification *)notification {
    [self layoutSubViews];
}


#pragma mark - Private Helpers

- (NSArray *)createLayersFromLines:(NSArray * )lines {
    NSMutableArray *layerContainer = [[NSMutableArray alloc] init];
    for (NSArray *line in lines) {
        NSMutableArray *oneColumn = [[NSMutableArray alloc] init];
        for (int row = 0; row < line.count; row++) {
            NSColor *color = [ColorHelper colorForIndex:row maxIndex:[line count]];
            CALayer *layer = [[CALayer alloc] init];
            layer.backgroundColor = color.CGColor;
            [self.view.layer addSublayer:layer];
            [oneColumn addObject:layer];
        }
        [layerContainer addObject:oneColumn];
    }
    
    return [layerContainer copy];
}

- (void)layoutSubViews {
    CGFloat fullHeight = self.view.bounds.size.height;
    CGFloat columnWidth = self.view.bounds.size.width / self.lines.count;
    
    NSUInteger column = 0;
    for (NSArray *line in self.lines) {
        column++;
        NSUInteger row = 0;
        CGFloat currentHeight = 0.0;
        CGFloat currentWidth = columnWidth * column;
        
        for (id value in line) {
            row++;
            CGFloat rowHeight = fullHeight * [value floatValue];
            
            CALayer *layer = self.layers[column - 1][row - 1];
            layer.frame = CGRectMake(currentWidth, currentHeight, columnWidth, rowHeight);

            currentHeight += fullHeight * [value floatValue];
        }
    }
}


@end
