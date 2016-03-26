//
//  CustomSegue.m
//  AppShoper
//
//  Created by juan on 3/23/16.
//  Copyright (c) 2016 juan. All rights reserved.
//

#import "CustomFlipSegue.h"

@implementation CustomFlipSegue
- (void) perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}
@end
