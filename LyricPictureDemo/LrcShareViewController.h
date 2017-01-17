//
//  LrcShareViewController.h
//  LyricPictureDemo
//
//  Created by silicon on 17/1/4.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LrcShareViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *shareLrcs;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImage *paperLayer;
@property (strong, nonatomic) UIView *pane;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) UIButton *saveBtn;

- (void)setLrcContent:(NSMutableArray *)selectLrcs;

@end
