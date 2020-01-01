//
//  AXHomeModel.h
//  AXTimeConcept
//
//  Created by lmm on 2020/1/1.
//  Copyright © 2020 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXHomeModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *desStr;

@property (nonatomic, strong) NSString *leftDays;

@end

NS_ASSUME_NONNULL_END
