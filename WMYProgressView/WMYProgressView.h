//
//  WMYProgressView.h
//  Workspace
//
//  Created by Wmy on 16/3/2.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface WMYProgressView : UIView

@property (nonatomic, strong, nullable) IBInspectable UIColor *trackColor;
@property (nonatomic, strong, nullable) IBInspectable UIColor *progressColor;
@property (nonatomic, strong, nullable) IBInspectable UIColor *progressOutsideColor;

@property (nonatomic) float progress;   // 0.0 .. 1.0, default is 0.0.
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
