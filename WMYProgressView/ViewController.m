//
//  ViewController.m
//  WMYProgressView
//
//  Created by Wmy on 16/3/2.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "ViewController.h"
#import "WMYProgressView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet WMYProgressView *progressView;
@property (nonatomic, weak) IBOutlet UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_slider addTarget:self action:@selector(action_slider:) forControlEvents:UIControlEventValueChanged];

    [self test];

}

#pragma mark - 

- (void)test {
    
    _slider.value = 0.2;
    _progressView.progress = 0.2;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_progressView setProgress:0.8 animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_progressView setProgress:1.0 animated:YES];
        });
    });
}

#pragma mark - event response

- (void)action_slider:(UISlider *)slider {
    [_progressView setProgress:slider.value animated:YES];
}

@end
