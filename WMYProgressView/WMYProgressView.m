//
//  WMYProgressView.m
//  Workspace
//
//  Created by Wmy on 16/3/2.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "WMYProgressView.h"

static CGFloat const timeInterval = 0.5;

@interface WMYProgressView ()
@property (nonatomic, strong) UIView *progressPercentV;
@property (nonatomic, weak) NSLayoutConstraint *percentConstraint;
@end

@implementation WMYProgressView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)awakeFromNib {
    [self configureUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setProgress:_progress];
}

#pragma mark - 

- (void)changeProgressPercentVColor {
    if (_progress >= 1.0) {
        _progressPercentV.backgroundColor = _progressOutsideColor;
    }else {
        _progressPercentV.backgroundColor = _progressColor;
    }
}

- (float)constantWithProgress:(float)progress {
    return -(1 - progress) * self.bounds.size.width;
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    
    _progress = progress <= 0.0 ? 0.0 : progress >= 1.0 ? 1.0 : progress;
    CGFloat constant = [self constantWithProgress:_progress];
    
    if (!animated) {
        _percentConstraint.constant = constant;
    }else {
        [UIView animateWithDuration:timeInterval animations:^{
            _percentConstraint.constant = constant;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
    
    [self changeProgressPercentVColor];
}

#pragma mark - setter

- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.backgroundColor = trackColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    [self changeProgressPercentVColor];
}

- (void)setProgressOutsideColor:(UIColor *)progressOutsideColor {
    _progressOutsideColor = progressOutsideColor;
    [self changeProgressPercentVColor];
}

#pragma mark - configureUI

- (void)configureUI {
    
    _progress = 0.0;
    
    [self addSubview:({
        _progressPercentV = [[UIView alloc] initWithFrame:CGRectZero];
        _progressPercentV.translatesAutoresizingMaskIntoConstraints = NO;
        _progressPercentV;
    })];
    [self addVFL];
    
    [self.layer setCornerRadius:self.bounds.size.height / 2.0];
    [_progressPercentV.layer setCornerRadius:self.bounds.size.height / 2.0];
    [self setClipsToBounds:YES];
    
    [self configureColor];
}

- (void)configureColor {
    if (!_trackColor) {
        self.trackColor = [UIColor colorWithRed:240/255.0
                                          green:240/255.0
                                           blue:240/255.0
                                          alpha:1];
    }
    if (!_progressColor) {
        self.progressColor = [UIColor colorWithRed:48/255.0
                                             green:172/255.0
                                              blue:54/255.0
                                             alpha:1];
    }
    if (!_progressOutsideColor) {
        self.progressOutsideColor = [UIColor orangeColor];
    }
}

#pragma mark - constraint

- (void)addVFL {
    
    [self removeConstraints:_progressPercentV.constraints];
    
    NSString *vfl1 = @"H:|-0-[progressV]";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"progressV" : _progressPercentV}]];
    NSString *vfl2 = @"V:|-0-[progressV]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"progressV" : _progressPercentV}]];
    
    _percentConstraint = [NSLayoutConstraint constraintWithItem:_progressPercentV
                                                      attribute:NSLayoutAttributeTrailingMargin
                                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeTrailingMargin
                                                     multiplier:1.0
                                                       constant:-self.bounds.size.width];
    [NSLayoutConstraint activateConstraints:@[_percentConstraint]];
    _percentConstraint.active = YES;
}

@end
