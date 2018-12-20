//
//  CustomKeyBoard.h
//  LyFuturesTrading
//
//  Created by 徐琰璋 on 2018/12/19.
//  Copyright © 2018 上海览益信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface NumberCell : UICollectionViewCell

@property(nonatomic,strong) NSString *itemTitle;

@end

@class CustomKeyBoard;

@protocol CustomKeyBoardDelegate<NSObject>

@optional
/**
 *  keyBoard  初始化
 *
 *  @param keyBoard      键盘实例
 *  @param textField     当前输入框对象
 *  @param text          点击的按键对象的文本
 */
- (void)keyBoard:(CustomKeyBoard *)keyBoard textField:(UITextField *)textField withFieldString:(NSString *)text;

@end

@interface CustomKeyBoard : UIView

/**
 *  initWithFrame  初始化
 *
 *  @param frame         frame
 *  @param textField     当前输入框对象
 */
- (instancetype)initWithFrame:(CGRect)frame textField:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
