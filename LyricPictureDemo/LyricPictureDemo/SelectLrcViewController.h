//
//  SelectLrcViewController.h
//  LyricPictureDemo
//
//  Created by silicon on 17/1/3.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LrcShareViewController.h"

@interface SelectLrcViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *lrcWordsArray;
@property (strong, nonatomic) UITableView *wordsTableView;
@property (strong, nonatomic) NSMutableArray *selectedLrcs;
@property (strong, nonatomic) LrcShareViewController *lrcShareView;

- (void)setLrcData:(NSMutableArray *)lrcdata;

@end
