//
//  AXHomeHeaderView.m
//  AXTimeConcept
//
//  Created by lmm on 2020/1/1.
//  Copyright © 2020 xiaoming. All rights reserved.
//

#import "AXHomeHeaderView.h"

@interface AXHomeHeaderView ()
@property (nonatomic, weak) IBOutlet UILabel *label;
@end

@implementation AXHomeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor orangeColor];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
}

- (void)loadInfo:(NSString *)info
{
    self.label.text = info;
}

@end
