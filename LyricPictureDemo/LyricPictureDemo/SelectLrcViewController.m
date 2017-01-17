//
//  SelectLrcViewController.m
//  LyricPictureDemo
//
//  Created by silicon on 17/1/3.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import "SelectLrcViewController.h"

@interface SelectLrcViewController ()

@end

@implementation SelectLrcViewController
@synthesize lrcWordsArray = _lrcWordsArray;
@synthesize wordsTableView = _wordsTableView;
@synthesize selectedLrcs = _selectedLrcs;

- (instancetype)init{
    self = [super init];
    
    self.lrcWordsArray = [[NSMutableArray alloc] init];
    self.selectedLrcs = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.navigationController.navigationBar);
    
    // Do any additional setup after loading the view.
    UIBarButtonItem *tempBarItem = [[UIBarButtonItem alloc] initWithTitle:@"生成图片" style:UIBarButtonItemStylePlain target:self action:@selector(generatePic)];

    self.navigationItem.rightBarButtonItem = tempBarItem;
    
    self.wordsTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.wordsTableView.delegate = self;
    self.wordsTableView.dataSource = self;
    [self.wordsTableView setBackgroundColor:[UIColor clearColor]];
    self.wordsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.wordsTableView.editing = YES;
    self.wordsTableView.allowsMultipleSelectionDuringEditing = YES;
    
    [self.view addSubview:self.wordsTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.wordsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setLrcData:(NSMutableArray *)lrcdata{
    self.lrcWordsArray = lrcdata;
}

- (void)generatePic{
    NSArray *selectIndex = [self.wordsTableView indexPathsForSelectedRows];
    if([selectIndex count] == 0 || !selectIndex){
        NSLog(@"请选择歌词");
        
        return;
    }
    
    [self.selectedLrcs removeAllObjects];
    
    for (int i = 0; i < [selectIndex count]; i++) {
        NSIndexPath *index = selectIndex[i];
        [self.selectedLrcs addObject:[self.lrcWordsArray objectAtIndex:index.row]];
    }
    
    if([self.selectedLrcs count] == 0){
        return;
    }
    
    if(!self.lrcShareView){
        self.lrcShareView = [LrcShareViewController new];
    }
    
    [self.lrcShareView setLrcContent:self.selectedLrcs];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType: kCATransitionFade];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [self.navigationController pushViewController:self.lrcShareView animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
}

#pragma -mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.lrcWordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.wordsTableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.lrcWordsArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}


@end
