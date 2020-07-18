//
//  ViewController.m
//  GoldenPyramideProblem
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Pyramide.h"
#import "PyramideBlockView.h"
#import "PyramideAlgorithm.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *pyramideStackView;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UITextField *pyramideSizeTextField;

@property (nonatomic) NSMutableArray* pyramideMutableArray;
@property (nonatomic) PyramideAlgorithm *pyramideAlgorithm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPyramideAlgorithm:[[PyramideAlgorithm alloc] init]];
}

- (IBAction)generateAndFindTapped:(UIButton *)sender {
    [self clearStackView: _pyramideStackView];
    if ([[_pyramideSizeTextField text] isEqualToString:@""]) {
        _pyramideMutableArray = [[NSMutableArray alloc] initWithPyramideSize: 10];
    } else {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *numFromString = [formatter numberFromString:[_pyramideSizeTextField text]];
        _pyramideMutableArray = [[NSMutableArray alloc] initWithPyramideSize: [numFromString intValue]];
    }
    [self configurePyramideUI];
    
    [self findRouteInPyramideUI];
}

- (IBAction)userTapped:(id)sender {
    [self.view endEditing:YES];
}

- (void)configurePyramideUI {
    for (int i = 0; i < _pyramideMutableArray.count; i++) {
        UIStackView *rowStack = [[UIStackView alloc] init];
        [rowStack setAxis:UILayoutConstraintAxisHorizontal];
        [rowStack setAlignment:UIStackViewAlignmentFill];
        [rowStack setDistribution:UIStackViewDistributionFillEqually];

        for (int q = 0; q < [[_pyramideMutableArray objectAtIndex:i] count]; q++) {
            PyramideBlockView *pyramideBlock = [[PyramideBlockView alloc] initWithFrame:CGRectZero];

            [[pyramideBlock blockNumberLabel] setText:[NSString stringWithFormat:@"%@", [[_pyramideMutableArray objectAtIndex:i] objectAtIndex:q]]];

            if (i % 2 == 0) {
                [pyramideBlock setBackgroundColor:[[UIColor alloc] initWithRed:1 green:1 blue:204/255 alpha:1]];
            } else {
                [pyramideBlock setBackgroundColor:[[UIColor alloc] initWithRed:0.5 green:0.6 blue:0.5 alpha:1]];
            }
            [rowStack addArrangedSubview:pyramideBlock];
        }
        [_pyramideStackView addArrangedSubview:rowStack];
    }
    
    [PyramideAlgorithm printPyramide:[self pyramideMutableArray]];
    
}

-(void)findRouteInPyramideUI {
    [[self routeLabel] setText:[[self pyramideAlgorithm] findRouteInPyramide:self.pyramideMutableArray]];
    
    for (int i = 0; i < [[[self pyramideAlgorithm] coordinates] count]; i++) {
        NSNumber *indexOfView = [[[[self pyramideAlgorithm] coordinates] objectAtIndex:i] lastObject];
        UIStackView *focusedStackView = [[[self pyramideStackView] arrangedSubviews] objectAtIndex:i];
        UIView *focusedView = [[focusedStackView arrangedSubviews] objectAtIndex:[indexOfView unsignedIntValue]];
        
        [focusedView setBackgroundColor:UIColor.redColor];
    }
}

- (void) clearStackView:(UIStackView *)stackView {
    for (UIView *view in [stackView arrangedSubviews]) {
        [view removeFromSuperview];
    }
}

@end
