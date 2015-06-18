//
//  BrowserViewController.h
//  GGID Sample
//
//  Created by Aditya Wirayudha on 18/06/15.
//  Copyright (c) 2015 Erasys Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrowserViewController;

@protocol BrowserViewControllerDelegate <NSObject>
- (void) browserViewControllerDidSuccessAuthenticate: (BrowserViewController *) sender;
@end

@interface BrowserViewController : UIViewController
@property (nonatomic, weak) id <BrowserViewControllerDelegate> delegate;
@end
