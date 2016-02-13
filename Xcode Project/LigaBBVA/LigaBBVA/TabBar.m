//
//  TabBar.m
//  LigaBBVA
//
//  Created by Héctor Gonzalo Andrés on 10/1/16.
//  Copyright (c) 2016 Héctor Gonzalo Andrés. All rights reserved.
//

#import "TabBar.h"
#import "HGAAppDelegate.h"

@interface TabBar ()

@end

@implementation TabBar

- (void)viewDidLoad
{
    appDelegate = (HGAAppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [appDelegate.aCambiar setBarTintColor:[UIColor colorWithRed:0.408 green:0.710 blue:0.620 alpha:1.00]];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
