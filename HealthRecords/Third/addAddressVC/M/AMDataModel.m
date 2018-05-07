//
//  AMDataModel.m
//  AMProject
//
//  Created by kys-6 on 2018/4/17.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import "AMDataModel.h"




@implementation AMDataModel

-(NSArray *)reloadDataWithPlist:(NSString *)name{
    NSString *plistPath1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"addressData.plist"];
    NSArray *data1 = [[NSArray alloc]initWithContentsOfFile:plistPath1];
    
    return data1;
}
+ (NSUInteger)dataCount{
    NSArray *dicArray = [[self alloc] reloadDataWithPlist:@"addressData"];
    return [dicArray count];
}
+ (NSDictionary *)reloadTheDetail:(NSInteger)count{
    NSArray *dicArray = [[self alloc] reloadDataWithPlist:@"addressData"];
    NSDictionary *dataDic = [dicArray objectAtIndex:count];


    return dataDic;
}

+ (void)setDicToPlist:(NSDictionary *)dic{
    //获取已有完整路径
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"addressData.plist"];

    NSArray *dicArray = [[self alloc] reloadDataWithPlist:@"addressData"];
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithArray:dicArray];
    [mArray addObject:dic];
    [mArray writeToFile:plistPath atomically:YES];
}

+ (void)replaceDicToPlist:(NSInteger)count andData:(NSDictionary *)dic{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"addressData.plist"];
    
    NSArray *dicArray = [[self alloc] reloadDataWithPlist:@"addressData"];
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithArray:dicArray];
    [mArray replaceObjectAtIndex:count withObject:dic];
    [mArray writeToFile:plistPath atomically:YES];
}

+ (void)deleteDicToPlist:(NSInteger)count{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"addressData.plist"];
    
    NSArray *dicArray = [[self alloc] reloadDataWithPlist:@"addressData"];
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithArray:dicArray];
    [mArray removeObjectAtIndex:count];
    [mArray writeToFile:plistPath atomically:YES];
}
+ (void)createEditableCopyOfPlistIfNeeded{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *filePatch = [documentsPath stringByAppendingPathComponent:@"addressData.plist"];
    BOOL Exists = [fileManager fileExistsAtPath:filePatch];

    if(!Exists){
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"addressData" ofType:@"plist"];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:plistPath toPath:filePatch error:&error];
        if(!success){
            NSAssert1(0, @"错误写入文件:'%@'.", [error localizedDescription]);
        }
    }
    
}
@end
