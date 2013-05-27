//
//  UIColor+THColor.m
//  TempApp
//
//  Created by Troy HARRIS on 5/20/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "UIColor+THColor.h"

@implementation UIColor (THColor)

+(UIColor *)colorFromHex:(NSString *)hex withAlpha:(CGFloat)alpha {
    NSString *filteredString = [hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *cleanHex;
    if ([hex rangeOfString:@"#"].location == NSNotFound) {
        cleanHex = filteredString;
    } else if ([hex rangeOfString:@"#"].location == 0){
        cleanHex = [filteredString substringFromIndex:1];
    } else {
        NSLog(@"THColor: Not a valid hex color. Hash appears somewhere other than the beginning");
        return nil;
    }
    if (cleanHex.length == 3) {
        NSString *shortRed = [cleanHex substringWithRange:NSMakeRange(0, 1)];
        NSString *shortGreen = [cleanHex substringWithRange:NSMakeRange(1, 1)];
        NSString *shortBlue = [cleanHex substringWithRange:NSMakeRange(2, 1)];
        cleanHex = [NSString stringWithFormat:@"%@%@%@%@%@%@", shortRed, shortRed, shortGreen, shortGreen, shortBlue, shortBlue];
    }
    if (cleanHex.length != 6) {
        NSLog(@"THColor: Not a valid hex color. Hex length wrong");
        return nil;
    }
    NSRange redRange = NSMakeRange(0, 2);
    NSRange greenRange = NSMakeRange(2, 2);
    NSRange blueRange = NSMakeRange(4, 2);
    NSString *redHex = [cleanHex substringWithRange:redRange];
    NSString *greenHex = [cleanHex substringWithRange:greenRange];
    NSString *blueHex = [cleanHex substringWithRange:blueRange];
    NSScanner *redScan = [NSScanner scannerWithString:redHex];
    NSScanner *greenScan = [NSScanner scannerWithString:greenHex];
    NSScanner *blueScan = [NSScanner scannerWithString:blueHex];
    unsigned int red;
    unsigned int green;
    unsigned int blue;
    [redScan scanHexInt:&red];
    [greenScan scanHexInt:&green];
    [blueScan scanHexInt:&blue];
    float redFloat = (float)red / 255;
    float greenFloat = (float)green / 255;
    float blueFloat = (float)blue / 255;
    return [UIColor colorWithRed:redFloat green:greenFloat blue:blueFloat alpha:alpha];
}

@end
