/**
 * 发现
 * @author 郑业强 2019-01-08 创建文件
 */

#import "FindCell.h"

#pragma mark - 声明
@interface FindCell()

@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UILabel *billLab;
@property (weak, nonatomic) IBOutlet UIImageView *nextBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *billConstraintL;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *monthDescLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyDescLab1;
@property (weak, nonatomic) IBOutlet UILabel *moneyDescLab2;
@property (weak, nonatomic) IBOutlet UILabel *moneyDescLab3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab1;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab2;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab3;

@end


#pragma mark - 实现
@implementation FindCell


- (void)initUI {
    [self.billLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.billLab setTextColor:kColor_Text_Black];
    [self.monthLab setFont:[UIFont systemFontOfSize:AdjustFont(18)]];
    [self.monthLab setTextColor:kColor_Text_Black];
    [self.monthDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.monthDescLab setTextColor:kColor_Text_Black];
    [self.moneyDescLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.moneyDescLab1 setTextColor:kColor_Text_Black];
    [self.moneyDescLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.moneyDescLab2 setTextColor:kColor_Text_Black];
    [self.moneyDescLab3 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.moneyDescLab3 setTextColor:kColor_Text_Black];
    [self.moneyLab1 setAttributedText:[NSAttributedString createMath:@"00.00" integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    [self.moneyLab2 setAttributedText:[NSAttributedString createMath:@"00.00" integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    [self.moneyLab3 setAttributedText:[NSAttributedString createMath:@"00.00" integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    [self.line setImage:[UIColor createImageWithColor:kColor_BG]];
    
    [self.billConstraintL setConstant:countcoordinatesX(15)];
    
    
    
    // 过滤
    NSDate *date = [NSDate date];
    NSMutableArray<BKModel *> *bookArr = [[PINCacheManager sharedManager] objectForKey:PIN_BOOK];
    NSString *str = [NSString stringWithFormat:@"year == %ld AND month == %ld", date.year, date.month];
    NSPredicate *pre = [NSPredicate predicateWithFormat:str];
    bookArr = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    
    
    pre = [NSPredicate predicateWithFormat:@"cmodel.is_income == 1"];
    NSMutableArray<BKModel *> *arrm1 = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    CGFloat income = [[arrm1 valueForKeyPath:@"@sum.price.floatValue"] floatValue];
    NSString *incomeStr = [NSString stringWithFormat:@"%.2f", income];
    [self.moneyLab1 setAttributedText:[NSAttributedString createMath:incomeStr integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    
    pre = [NSPredicate predicateWithFormat:@"cmodel.is_income == 0"];
    NSMutableArray<BKModel *> *arrm2 = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    CGFloat pay = [[arrm2 valueForKeyPath:@"@sum.price.floatValue"] floatValue];
    NSString *payStr = [NSString stringWithFormat:@"%.2f", pay];
    [self.moneyLab2 setAttributedText:[NSAttributedString createMath:payStr integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    
    
    NSString *sum = [NSString stringWithFormat:@"%.2f", income - pay];
    [self.moneyLab3 setAttributedText:[NSAttributedString createMath:sum integer:[UIFont systemFontOfSize:AdjustFont(14)] decimal:[UIFont systemFontOfSize:AdjustFont(12)]]];
    
    
}


@end