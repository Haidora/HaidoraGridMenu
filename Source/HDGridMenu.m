//
//  HDGridMenu.m
//  HaidoraGridMenu
//
//  Created by DaiLingchi on 14-10-18.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDGridMenu.h"

#define kMargin_Edge 8
#define kMargin_Item 10

@interface HDGridMenu ()

@end

@implementation HDGridMenu

#pragma mark
#pragma mark Init

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithMenus:(NSArray *)menus
{
    self = [self init];
    if (self)
    {
        [self commonInit];
        _items = menus;
        [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HDGridMenuItem *item = obj;
            item.tag = idx;
            [item addTarget:self
                          action:@selector(menuSelected:)
                forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:obj];
        }];
    }
    return self;
}

- (void)commonInit
{
    _edgeInsets = UIEdgeInsetsMake(kMargin_Edge, kMargin_Edge, kMargin_Edge, kMargin_Edge);
    _itemMargin = kMargin_Item;
    _selectedIndexs = [NSMutableArray array];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HDGridMenuItem *item = obj;
        item.tag = idx;
        [item addTarget:self
                      action:@selector(menuSelected:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:obj];
    }];
    [self setNeedsLayout];
}

#pragma mark
#pragma mark Render

- (void)layoutSubviews
{
    [self layoutMenus];
}

- (void)layoutMenus
{
    __block CGFloat posX = _edgeInsets.left;
    __block CGFloat posY = _edgeInsets.top;
    CGFloat maxWidth = CGRectGetWidth(self.bounds);
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HDGridMenuItem *item = obj;
        [item sizeToFit];
        if (0 == _colums)
        {
            CGFloat itemWidth = MAX(_minWidth, CGRectGetWidth(item.bounds));
            CGFloat itemHeight = MAX(_minHeight, CGRectGetHeight(item.bounds));
            if ((posX + itemWidth + MIN(_itemMargin, _edgeInsets.right)) < maxWidth)
            {
                item.frame = CGRectMake(posX, posY, itemWidth, itemHeight);
                posX += itemWidth + _itemMargin;
            }
            else
            {
                posX = _edgeInsets.left;
                posY += _edgeInsets.top + itemHeight;
                item.frame = CGRectMake(posX, posY, itemWidth, itemHeight);
                posX += itemWidth + _itemMargin;
            }
        }
        else
        {
            CGFloat itemWidth =
                (maxWidth - (_colums - 1) * _itemMargin - _edgeInsets.left - _edgeInsets.right) /
                _colums;
            CGFloat itemHeight = MAX(_minHeight, CGRectGetHeight(item.bounds));
            if ((posX + itemWidth + MIN(_itemMargin, _edgeInsets.right)) < maxWidth)
            {
                item.frame = CGRectMake(posX, posY, itemWidth, itemHeight);
                posX += itemWidth + MIN(_itemMargin, _edgeInsets.right);
            }
            else
            {
                posX = _edgeInsets.left;
                posY += _edgeInsets.top + itemHeight;
                item.frame = CGRectMake(posX, posY, itemWidth, itemHeight);
                posX += itemWidth + _itemMargin;
            }
        }
        if ([_selectedIndexs containsObject:@(idx)])
        {
            item.selected = YES;
        }
        else
        {
            item.selected = NO;
        }
    }];
}

- (void)menuSelected:(HDGridMenuItem *)item
{
    item.selected = !item.selected;
    [self setSelectedAtIndex:item.tag];
}

- (void)setSelectedAtIndex:(NSInteger)index
{
    if (_canMuliteSelect)
    {
        if ([_selectedIndexs containsObject:@(index)])
        {
            [_selectedIndexs removeObject:@(index)];
        }
        else
        {
            [_selectedIndexs addObject:@(index)];
        }
    }
    else
    {
        [_selectedIndexs removeAllObjects];
        [_selectedIndexs addObject:@(index)];
    }
    [self setNeedsLayout];
}

- (void)setSelectedIndexs:(NSMutableArray *)selectedIndexs
{
    _selectedIndexs = selectedIndexs;
    [self setNeedsLayout];
}

@end

#pragma mark
#pragma mark HDGridMenuItem

@implementation HDGridMenuItem

- (id)initWithTitle:(NSString *)title
{
    self = [self init];
    if (self)
    {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateSelected];

        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        [self setTitleColor:self.tintColor forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.userInteractionEnabled = YES;
        self.layer.borderColor = self.tintColor.CGColor;
        self.layer.borderWidth = 1;
        [self setSelected:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.backgroundColor = self.tintColor;
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
