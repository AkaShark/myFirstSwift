//
//  GBigbangBox.h
//  GBigbang
//
//  Created by GIKI on 2017/10/19.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GBigbangItem;

/**
 负责分词
 */
@interface GBigbangBox : NSObject

+ (NSArray<GBigbangItem*>*)bigBang:(NSString*)string;

@end

@interface GBigbangItem : NSObject
@property (nonatomic, copy,readonly) NSString * text;
@property (nonatomic, assign,readonly) BOOL isSymbolOrEmoji;
+(instancetype)bigbangText:(NSString*)text isSymbol:(BOOL)isSymbol;
@end
