//
//  CustomKeyBoard.m
//  LyFuturesTrading
//
//  Created by 徐琰璋 on 2018/12/19.
//  Copyright © 2018 上海览益信息科技有限公司. All rights reserved.
//

#import "CustomKeyBoard.h"
#import "UIView+DropShadow.h"

static CGFloat const kItemSpacing = 6;  //每个按钮之间的间距

#define FONT_PingFang_Regular(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kKeyBoardHeight (0.35 * SCREEN_HEIGHT)//整个键盘的高度
#define kItemW (SCREEN_WIDTH - 4 * kItemSpacing) / 3 //按钮的宽度
#define kItemH (kKeyBoardHeight - 5 * kItemSpacing) / 4 //按钮的高度

@interface NumberCell()

@property(nonatomic,copy) UILabel        *titleLabel;
@property(nonatomic,copy) UIButton       *deleteButton;

@end

@implementation NumberCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setLayout];
    }
    return self;
}

-(void) setupUI{
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.deleteButton];
}

-(void) setLayout{
    
    self.titleLabel.frame = CGRectMake(0, 0, kItemW, kItemH);
    self.deleteButton.frame = CGRectMake(0, 0, kItemW, kItemH);
}

-(void)setItemTitle:(NSString *)itemTitle{

    self.contentView.backgroundColor = [UIColor whiteColor];
    self.titleLabel.hidden = YES;
    self.deleteButton.hidden = YES;
    if ([itemTitle isEqualToString:@"10"]) {
        self.titleLabel.hidden = NO;
        self.titleLabel.text = @"·";
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor clearColor];
    }else if ([itemTitle isEqualToString:@"12"]){
        self.deleteButton.hidden = NO;
        self.contentView.backgroundColor = [UIColor clearColor];
    }else{
        [self.contentView dropShadowWithOffset:CGSizeMake(0, 2) radius:1.5 color:[UIColor blackColor] opacity:0.3];
        self.titleLabel.hidden = NO;
        self.titleLabel.text = itemTitle;
    }
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = FONT_PingFang_Regular(25);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)deleteButton{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"delete_key_icon"] forState:UIControlStateNormal];
        _deleteButton.userInteractionEnabled = NO;
    }
    return _deleteButton;
}

@end

@interface CustomKeyBoard ()<UICollectionViewDelegate,UICollectionViewDataSource>

//数字键盘
@property (copy,nonatomic)     UICollectionView *keyBoardView;
//输入框对象
@property (strong,nonatomic)   UITextField *textField;
//数字数组
@property (strong,nonatomic)   NSArray *itemArray;

@end

@implementation CustomKeyBoard

- (instancetype)initWithFrame:(CGRect)frame textField:(UITextField *)textField
{
    self = [super initWithFrame:frame];
    if (self) {
        if (textField) {
            self.textField = textField;
        }
        [self setupUI];
        [self setLayout];
    }
    return self;
}

-(void) setupUI{
    
    self.frame = CGRectMake(0, 200, SCREEN_WIDTH, kKeyBoardHeight);
    self.backgroundColor = [UIColor colorWithRed:210/255.0 green:213/255.0 blue:219/255.0 alpha:1];
    [self addSubview:self.keyBoardView];
}

-(void) setLayout{
    
    self.keyBoardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kKeyBoardHeight);
}

#pragma mark - 键盘事件处理
//要显示的数字处理
- (void)showInput:(UITextField *)textField text:(NSString *)text {
    if (!textField) {
        return;
    }
    if ([@"10" isEqualToString:text]) {
        if (![textField.text containsString:@"."]) {
            NSString *newStr = [textField.text stringByAppendingString:@"."];
            textField.text = newStr;
        }
    }else if([@"11" isEqualToString:text]) {
        NSString *newStr = [textField.text stringByAppendingString:@"0"];
        textField.text = newStr;
    }else if([@"12" isEqualToString:text]) {
        if (textField.text.length > 0) {
            NSString *newStr = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = newStr;
        }
    }else {
        NSString *newStr = [textField.text stringByAppendingString:text];
        textField.text = newStr;
    }
}

#pragma mark - UICollectionViewDelegate/UICollectionViewData

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NumberCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
    [cell setItemTitle:self.itemArray[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"itemArray[i] = %@",self.itemArray[indexPath.item]);
    [self showInput:self.textField text:self.itemArray[indexPath.item]];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.item != 9 && indexPath.item != 11) {
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.item != 9 && indexPath.item != 11) {
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    }
}

#pragma mark - getters and setters

-(UICollectionView *)keyBoardView{
    if (_keyBoardView == nil) {
        //布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = kItemSpacing;
        flowLayout.minimumLineSpacing = kItemSpacing;
        flowLayout.sectionInset = UIEdgeInsetsMake(kItemSpacing, kItemSpacing, kItemSpacing, kItemSpacing);
        flowLayout.itemSize = CGSizeMake(kItemW, kItemH);
        _keyBoardView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_keyBoardView registerClass:[NumberCell class] forCellWithReuseIdentifier:@"NumberCell"];
        _keyBoardView.delegate = self;
        _keyBoardView.dataSource = self;
        _keyBoardView.backgroundColor = [UIColor colorWithRed:210/255.0 green:213/255.0 blue:219/255.0 alpha:1];
    }
    return _keyBoardView;
}

-(NSArray *)itemArray{
    if (!_itemArray) {
        _itemArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"0",@"12"];
    }
    return _itemArray;
}

@end
