//
//  PyramideBlockView.h
//  GoldenPyramideProblem
//
//  Created by Eric Golovin on 7/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PyramideBlockView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *blockNumberLabel;

@end

NS_ASSUME_NONNULL_END
