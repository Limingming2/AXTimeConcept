//
//  AXHomeCell.m
//  AXTimeConcept
//
//  Created by lmm on 2020/1/1.
//  Copyright © 2020 xiaoming. All rights reserved.
//

#import "AXHomeCell.h"
#import "AXHomeModel.h"


@interface AXHomeCell ()

@property (nonatomic, weak) IBOutlet UITextField *timeTF;
@property (nonatomic, weak) IBOutlet UIButton *btn;
@property (nonatomic, weak) IBOutlet UILabel *timeLab;

@end

@implementation AXHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo:(AXHomeModel *)info
{
//    self.timeLab.text = ;
    NSString *str = [NSString stringWithFormat:@"您设定的时间：%@\n还剩 %@ 天", info.time, info.leftDays];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSString *rangeStr = [NSString stringWithFormat:@" %@ ", info.leftDays];
    [attrStr setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:28]} range:[str rangeOfString:rangeStr]];
    self.timeLab.attributedText = attrStr;
    self.timeTF.placeholder = info.desStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
