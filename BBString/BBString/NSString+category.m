//
//  NSString+category.m
//  BBString
//
//  Created by 程肖斌 on 2019/1/29.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "NSString+category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (category)

- (NSString *)toMD5{
    const char *cStr = [self UTF8String];
    unsigned char result[16] = {0};
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *md5 = [NSMutableString string];
    for(NSInteger index = 0; index < 16; index++){
        [md5 appendFormat:@"%02x",result[index]];
    }
    
    return md5;
}

- (NSString *)toSHA1{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[20] = {0};
    uint32_t len = (uint32_t)data.length;
    CC_SHA1(data.bytes, len, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:40];
    for(int i = 0; i < 20; i++){
        [output appendFormat:@"%02x",digest[i]];
    }
    
    return output;
}

- (NSMutableAttributedString *)fromHtml{
    NSDictionary *opts = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    NSData *data = [self dataUsingEncoding:NSUnicodeStringEncoding];
    return [[NSMutableAttributedString alloc]initWithData:data
                                                  options:opts
                                       documentAttributes:nil
                                                    error:nil];
}

- (NSMutableAttributedString *)fromImage:(UIImage *)image bounds:(CGRect)bounds{
    NSTextAttachment *atta = [[NSTextAttachment alloc]init];
    atta.image  = image;
    atta.bounds = bounds;
    return [NSAttributedString attributedStringWithAttachment:atta].mutableCopy;
}

- (NSMutableAttributedString *)attribute:(NSArray<NSNumber *> *)lengths
                                   types:(NSArray<NSNumber *> *)types
                                   fonts:(NSArray<NSNumber *> *)fonts
                                  values:(NSArray<NSNumber *> *)values{
    NSMutableArray *colors = [NSMutableArray array];
    for(NSNumber *value in values){
        UIColor *color = RGB_16(value.integerValue, 1);
        [colors addObject:color];
    }
    return [self attribute:lengths
                     types:types
                     fonts:fonts
                    colors:colors];
}

- (NSMutableAttributedString *)attribute:(NSArray<NSNumber *> *)lengths
                                   types:(NSArray<NSNumber *> *)types
                                   fonts:(NSArray<NSNumber *> *)fonts
                                  colors:(NSArray<UIColor *> *)colors{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self];
    NSInteger length = 0;
    for(NSInteger index = 0; index < lengths.count; index ++){
        NSInteger len  = lengths[index].integerValue;
        NSInteger type = types[index].integerValue;
        CGFloat font   = types[index].floatValue;
        UIColor *color = colors[index];
        UIFont *fontName = nil;
        switch (type) {
            case BBFontThin:
                fontName = [UIFont italicSystemFontOfSize:factor(font)];
                break;
            case BBFontSystem:
                fontName = [UIFont systemFontOfSize:factor(font)];
                break;
            case BBFontBold:
                fontName = [UIFont boldSystemFontOfSize:factor(font)];
                break;
            default:
                break;
        }
        NSDictionary *dict = @{NSForegroundColorAttributeName : color,
                               NSFontAttributeName : fontName};
        [attr addAttributes:dict range:NSMakeRange(length, len)];
        len += length;
    }
    return attr;
}

- (BOOL)charValue{
    return [self integerValue];
}

- (int64_t)unsignedLongLongValue{
    return [self longLongValue];
}

@end
