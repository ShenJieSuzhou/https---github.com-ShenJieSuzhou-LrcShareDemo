//
//  ViewController.m
//  LyricPictureDemo
//
//  Created by silicon on 17/1/3.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize lrcTableView = _lrcTableView;
@synthesize parseUtil = _parseUtil;
@synthesize selectLrcView = _selectLrcView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Silicon Demo";
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.lrcTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.lrcTableView.delegate = self;
    self.lrcTableView.dataSource = self;
    
    [self.lrcTableView setBackgroundColor:[UIColor clearColor]];
    self.lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.lrcTableView];
    
    //解析歌词
    self.parseUtil = [[LrcParseUtil alloc] init];
    [self.parseUtil parseLrc:[self.parseUtil getLrcFile:@"demoSong"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.selectLrcView){
        self.selectLrcView = [SelectLrcViewController new];
    }
    
    [self.selectLrcView setLrcData:self.parseUtil.wordArray];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType: kCATransitionFade];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [self.navigationController pushViewController:self.selectLrcView animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.parseUtil.wordArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.lrcTableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.parseUtil.wordArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor=[UIColor clearColor];

    
    return cell;
}

@end
