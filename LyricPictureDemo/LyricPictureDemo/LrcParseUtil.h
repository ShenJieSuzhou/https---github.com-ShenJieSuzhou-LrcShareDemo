//
//  LrcParseUtil.h
//  LyricPictureDemo
//
//  Created by silicon on 17/1/3.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcParseUtil : NSObject
//时间
@property (nonatomic,strong) NSMutableArray *timerArray;
//歌词
@property (nonatomic,strong) NSMutableArray *wordArray;

-(NSString *)getLrcFile:(NSString *)lrc;

//解析歌词
-(void) parseLrc:(NSString*)lrc;

@end
