//
//  PyramideBlockView.m
//  GoldenPyramideProblem
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import "PyramideBlockView.h"

@implementation PyramideBlockView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [[NSBundle mainBundle] loadNibNamed:@"PyramideBlock" owner:self options:nil];
    [self addSubview:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[self contentView] setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [[self contentView] setBackgroundColor:backgroundColor];
}

@end
