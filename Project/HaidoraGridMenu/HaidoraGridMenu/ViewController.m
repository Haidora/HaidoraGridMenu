//
//  ViewController.m
//  HaidoraGridMenu
//
//  Created by DaiLingchi on 14-10-18.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "ViewController.h"
#import "HDGridMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *Menus = [NSMutableArray array];
    HDGridMenuItem *item = [[HDGridMenuItem alloc] initWithTitle:@"手动"];
    //    item.backgroundColor = [UIColor redColor];
    //    [item setTitle:@"手动" forState:UIControlStateNormal];
    [Menus addObject:item];
    item = [[HDGridMenuItem alloc] init];
    //    item.backgroundColor = [UIColor redColor];
    [item setTitle:@"自动" forState:UIControlStateNormal];
    [Menus addObject:item];

    for (int i = 0; i < 100; i++)
    {
        HDGridMenuItem *item =
            [[HDGridMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Test%d", i]];
        [Menus addObject:item];
    }
    HDGridMenu *menu = [[HDGridMenu alloc] initWithMenus:Menus];
    menu.selectedIndexs = [@[ @(0), @(1), @(3) ] mutableCopy];
    menu.minWidth = 100;
    menu.canMuliteSelect = YES;
//        menu.colums = 3;
    menu.frame = self.view.bounds;
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
