//
//  AXHomeCell.h
//  AXTimeConcept
//
//  Created by lmm on 2020/1/1.
//  Copyright © 2020 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AXHomeModel;

NS_ASSUME_NONNULL_BEGIN

@interface AXHomeCell : UITableViewCell
- (void)loadInfo:(AXHomeModel *)info;
@end

NS_ASSUME_NONNULL_END
