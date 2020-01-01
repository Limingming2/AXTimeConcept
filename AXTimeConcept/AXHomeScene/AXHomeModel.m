//
//  AXHomeModel.m
//  AXTimeConcept
//
//  Created by lmm on 2020/1/1.
//  Copyright © 2020 xiaoming. All rights reserved.
//

#import "AXHomeModel.h"

@implementation AXHomeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [self init];
    if (self) {
        self.time = dic[@"time"];
        self.desStr = dic[@"des"];
    }
    return self;
}

- (NSString *)leftDays
{
    NSString *result;
    // 20200825
    if (self.time.length > 0) {
        
        NSString *timeStr = self.time;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        formatter.dateFormat = @"yyyyMMdd";
        NSDate *date = [formatter dateFromString:timeStr];
        
        NSDate *currentDate = [NSDate date];
        NSString *currentStr = [formatter stringFromDate:currentDate];
        currentDate = [formatter dateFromString:currentStr];
        NSTimeInterval timeInterval = date.timeIntervalSince1970;
        NSTimeInterval currentTimeInterval = currentDate.timeIntervalSince1970;
        if (currentTimeInterval < timeInterval) {
            NSTimeInterval time = timeInterval - currentTimeInterval;
            NSInteger day = time / 3600 / 24;
            result = [NSString stringWithFormat:@"%zd", day];
        }else {
            result = @"0";
        }
        
        
    }else {
        result = @"0";
    }
    return result;
}

@end
