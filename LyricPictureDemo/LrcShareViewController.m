//
//  LrcShareViewController.m
//  LyricPictureDemo
//
//  Created by silicon on 17/1/4.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import "LrcShareViewController.h"
#import "ConstantUtil.h"
@interface LrcShareViewController ()

@end

@implementation LrcShareViewController
@synthesize shareLrcs = _shareLrcs;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;
@synthesize paperLayer = _paperLayer;
@synthesize shareBtn = _shareBtn;
@synthesize saveBtn = _saveBtn;
@synthesize pane = _pane;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set scrollView and share & save Btn
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = self.view.bounds.size;
    _scrollView.scrollEnabled = YES;
    [self.view addSubview:_scrollView];
    
    [self addShareAndSaveBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    // init the imageView
    self.imageView = [UIImageView new];
    
    // resize the background image , adapte to the lrcs
    self.paperLayer = [self drawLrcsWithImageContext:[UIImage imageNamed:@"simple.png"]];
    [self.imageView setImage:self.paperLayer];
    
    //add labels on the imageView
    [self addLyricToBackground:self.shareLrcs];
    [self.scrollView addSubview:self.imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *@brief 添加分享与保存按钮
 */
- (void)addShareAndSaveBtn{
    self.pane = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 35.0f, self.view.bounds.size.width, 35.f)];
    [self.pane setBackgroundColor:[UIColor clearColor]];
    
    self.shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 2, 35.0f)];
    [self.shareBtn setBackgroundColor:[UIColor colorWithRed:23.0f green:24.0f blue:24.0f alpha:0]];
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setTintColor:[UIColor whiteColor]];
    [self.shareBtn addTarget:self action:@selector(socialCCshare) forControlEvents:UIControlEventTouchDown];
    
    self.saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 + 1, 0, self.view.bounds.size.width / 2, 35.0f)];
    [self.saveBtn setBackgroundColor:[UIColor colorWithRed:23.0f green:24.0f blue:24.0f alpha:0]];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTintColor:[UIColor whiteColor]];
    [self.saveBtn addTarget:self action:@selector(saveToPhoto) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 0, 1, 35)];
    [line setBackgroundColor:[UIColor whiteColor]];
    
    [self.pane addSubview:self.shareBtn];
    [self.pane addSubview:self.saveBtn];
    [self.pane addSubview:line];
    [self.view addSubview:self.pane];
}

- (void)socialCCshare{
    NSLog(@"分享");
}

/*
 *@brief 保存至手机相册
 */
- (void)saveToPhoto{
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, YES, 0.0);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *bitmap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(bitmap, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    
    NSLog(@"%@", msg);
}

- (void)setLrcContent:(NSMutableArray *)selectLrcs{
    self.shareLrcs = selectLrcs;
}

/*
 *@brief 动态添加歌词到UIImageView
 *@param lrcsArray 歌词
 */
- (void)addLyricToBackground:(NSMutableArray *)lrcsArray{
    
    CGFloat point_x = 40.0f;
    CGFloat point_y = 50.0f;
    CGFloat t_per_size = 15.0f;
    CGFloat row_height = 20.0f;
    CGFloat margin = 10.0f;
    
    for(int i = 0; i < [lrcsArray count]; i++){
        //get lrc from array
        NSString *lrc = [lrcsArray objectAtIndex:i];
        int lrcLen = lrc.length;
        
        //create a label to show the lrc
        UILabel *lrcLabel = [[UILabel alloc] initWithFrame:CGRectMake(point_x, point_y + i * (row_height + margin), lrcLen * t_per_size, row_height)];
        
        [lrcLabel setText:lrc];
        lrcLabel.font = [UIFont fontWithName:@"Arial" size:15];
        lrcLabel.textColor = [UIColor lightGrayColor];
        [self.imageView addSubview:lrcLabel];
    }
    
    //note the song's name
    NSString *songName = @"── [不为谁而做的歌]";
    CGFloat y_songName = self.imageView.frame.size.height - 90.0f;
    CGFloat width_songName = self.imageView.frame.size.width - 80.0f;
    UILabel *songFrom = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - width_songName)/2, y_songName, width_songName, row_height)];
    [songFrom setText:songName];
    songFrom.font = [UIFont fontWithName:@"Arial" size:15];
    songFrom.textColor = [UIColor lightGrayColor];
    [songFrom setTextAlignment:NSTextAlignmentRight];
    [self.imageView addSubview:songFrom];
}


/*
 * @brief 拉伸背景图片达到满足背景的要求
 * @param layerImage 背景图片
 */
- (UIImage *)drawLrcsWithImageContext:(UIImage *)layerImage{
    CGFloat rowHeight = 20.0f;
    CGFloat margins = 5.0f;
  
    /*
     *背景海报的高度
     *header iphone 固定为80px
     *footer iphone 固定为120px
     */
    CGFloat imageHeight = (rowHeight + margins) * [self.shareLrcs count];
    //背景海报的宽度为屏幕固定宽度
    CGFloat imageWidth = self.view.bounds.size.width;

    [self.imageView setFrame:CGRectMake(0, 0, imageWidth, 200 + imageHeight)];
    
    CGFloat top = layerImage.size.height /2 - 1;
    CGFloat left = layerImage.size.width /2 - 1;
    CGFloat bottom = layerImage.size.height /2 - 1;
    CGFloat right = layerImage.size.width /2 - 1;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    // 拉伸图片
    UIImage *newImage = [layerImage resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
    return newImage;
}

@end
