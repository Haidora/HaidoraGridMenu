//
//  HDGridMenu.h
//  HaidoraGridMenu
//
//  Created by DaiLingchi on 14-10-18.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDGridMenuItem;

#pragma mark
#pragma mark HDGridMenu

@interface HDGridMenu : UIView

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat itemMargin;
@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat minHeight;
/**
 *  The Menu colus,if not set will order one by one.
 */
@property (nonatomic, assign) NSUInteger colums;
@property (nonatomic, assign) BOOL canMuliteSelect;

@property (nonatomic, strong) NSMutableArray *selectedIndexs;
- (id)initWithMenus:(NSArray *)menus;

@end

#pragma mark
#pragma mark HDGridMenuItem

@interface HDGridMenuItem : UIButton

- (id)initWithTitle:(NSString *)title;

@end
