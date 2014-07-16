//
//  HaoPageViewController.m
//  HaoTestPageViewController
//
//  Created by Hao Zheng on 7/15/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "HaoPageViewController.h"

@interface HaoPageViewController () <UIPageViewControllerDataSource>
@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSDictionary *dict;

@property (nonatomic,strong) UIViewController *VC1;
@property (nonatomic,strong) UIViewController *VC2;

@end

@implementation HaoPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC1"];
    self.VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
    
    self.menu = [NSArray arrayWithObjects:self.VC1, self.VC2, nil];
    
    //a dictionary that knows which index giving a class name of VC
    self.dict = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSNumber numberWithInt:0], self.VC1.restorationIdentifier,
                 [NSNumber numberWithInt:1], self.VC2.restorationIdentifier,
                 nil];
    
    self.dataSource = self;
    
    for(int i = (int)([self.menu count] - 1); i>=0;i--){
        [self setViewControllers:@[self.menu[i]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }

}


-(NSUInteger)getVCIndex:(UIViewController *) vc{
    NSUInteger index = [[self.dict objectForKey:vc.restorationIdentifier] integerValue];
    return index;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"*******************  pageViewController before *******************");

    
    NSUInteger index = [self getVCIndex:viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return self.menu[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"*******************  pageViewController after *******************");

    
    NSUInteger index = [self getVCIndex:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.menu count]) {
        return nil;
    }
    return self.menu[index];
}

@end
