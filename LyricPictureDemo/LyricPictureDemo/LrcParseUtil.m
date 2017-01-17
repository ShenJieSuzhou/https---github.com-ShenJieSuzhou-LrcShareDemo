//
//  LrcParseUtil.m
//  LyricPictureDemo
//
//  Created by silicon on 17/1/3.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import "LrcParseUtil.h"

@implementation LrcParseUtil
@synthesize timerArray = _timerArray;
@synthesize wordArray = _wordArray;


-(instancetype) init{
    self=[super init];
    if(self!=nil){
        self.timerArray=[[NSMutableArray alloc] init];
        self.wordArray=[[NSMutableArray alloc] init];
    }
    return  self;
}

-(NSString *)getLrcFile:(NSString *)lrc{
    NSString* filePath=[[NSBundle mainBundle] pathForResource:lrc ofType:@"lrc"];
    return  [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}

-(void)parseLrc:(NSString *)lrc{
    if(![lrc isEqual:nil]){
        NSArray *sepArray=[lrc componentsSeparatedByString:@"["];
        NSArray *lineArray=[[NSArray alloc] init];
        for(int i=0;i<sepArray.count;i++){
            if([sepArray[i] length]>0){
                lineArray=[sepArray[i] componentsSeparatedByString:@"]"];
                if(![lineArray[0] isEqualToString:@"\n"]){
                    [self.timerArray addObject:lineArray[0]];
                    [self.wordArray addObject:lineArray.count>1?lineArray[1]:@""];
                }
            }
        }
    }
}

@end
