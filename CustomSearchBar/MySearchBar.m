//
//  MySearchBar.m
//  juiker
//
//  Created by iceboxi on 2016/1/13.
//  Copyright © 2016年 李承翰. All rights reserved.
//

#import "MySearchBar.h"

@implementation MySearchBar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.searchBarStyle = UISearchBarStyleProminent;
        self.translucent = false;
        self.backgroundColor = [UIColor whiteColor];
        labelBool = iconBool = NO;
        self.placeholder = @"search";
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UITextField *textField = [self getTextField];
    if (textField) {
        textField.frame = CGRectMake(0., 0., CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        textField.backgroundColor = [UIColor whiteColor];
        self.barTintColor = textField.backgroundColor;
        self.tintColor = textField.textColor;
        self.layer.borderWidth = 1;
        self.layer.borderColor = self.barTintColor.CGColor;
    }
    
    CGPoint startPoint = CGPointMake(0, CGRectGetHeight(self.bounds)-1);
    CGPoint endPoint = CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-1);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:0 alpha:0.12].CGColor;
    shapeLayer.lineWidth = 1.0;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UILabel *label = [self getTextFieldLabel];
    UIImageView *icon = [self getSearchIcon];
    if (label && !labelBool) {
        [label addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        labelBool = YES;
    }
    if (icon && !iconBool) {
        [icon addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        iconBool = YES;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([object isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)object;
        [label removeObserver:self forKeyPath:@"frame"];
        label.frame = CGRectMake(35, CGRectGetMinY(label.frame), CGRectGetWidth(self.bounds)-35-10, CGRectGetHeight(label.frame));
        [label addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    if ([object isKindOfClass:[UIImageView class]]) {
        UIImageView *icon = (UIImageView *)object;
        [icon removeObserver:self forKeyPath:@"frame"];
        icon.frame = CGRectMake(10, CGRectGetMinY(icon.frame)-1, 15, 15);
        [icon addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (UITextField *)getTextField
{
    return (UITextField *)ViewWithSuffix(self, @"UISearchBarTextField");
}

- (UILabel *)getTextFieldLabel
{
    return (UILabel *)ViewWithSuffix(self, @"UISearchBarTextFieldLabel");
}

- (UIImageView *)getSearchIcon
{
    return (UIImageView *)ViewWithSuffix(self, @"UIImageView");
}

static UIView *ViewWithSuffix(UIView *view, NSString *classNameSuffix) {
    if (!view || classNameSuffix.length == 0) return nil;
    
    UIView *theView = nil;
    for (__unsafe_unretained UIView *subview in view.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:classNameSuffix]) {
            return subview;
        }else {
            if ((theView = ViewWithSuffix(subview, classNameSuffix))) break;
        }
    }
    
    return theView;
}
@end
