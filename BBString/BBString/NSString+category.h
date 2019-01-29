//
//  NSString+category.h
//  BBString
//
//  Created by 程肖斌 on 2019/1/29.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBString.h"
#import <UIKit/UIKit.h>

@interface NSString (category)

//转成md5编码
- (NSString *)toMD5;

//转成sha1编码
- (NSString *)toSHA1;

//将html数据转成字符串
- (NSMutableAttributedString *)fromHtml;

//将图片转成字符串
- (NSMutableAttributedString *)fromImage:(UIImage *)image
                                  bounds:(CGRect)bounds;

//设置富文本
- (NSMutableAttributedString *)attribute:(NSArray<NSNumber *> *)lengths
                                   types:(NSArray<NSNumber *> *)types
                                   fonts:(NSArray<NSNumber *> *)fonts
                                  values:(NSArray<NSNumber *> *)values;

- (NSMutableAttributedString *)attribute:(NSArray<NSNumber *> *)lengths
                                   types:(NSArray<NSNumber *> *)types
                                   fonts:(NSArray<NSNumber *> *)fonts
                                  colors:(NSArray<UIColor *> *)colors;

//ios10.3.3系统没有charValue、unsignedLongLingValue方法，在这里转一下
- (BOOL)charValue;

- (int64_t)unsignedLongLongValue;

@end

