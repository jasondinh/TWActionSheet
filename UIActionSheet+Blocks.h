//
//  UIActionSheet+Blocks.h
//
//  Created by Jason Dinh on 16/1/12.
//  Copyright (c) 2012 bathanh@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CancelBlock) (UIActionSheet *actionSheet);
typedef void (^ClickBlock) (UIActionSheet *actionSheet, NSUInteger idx);
typedef void (^WillDismissBlock) (UIActionSheet *actionSheet, NSUInteger idx);
typedef void (^DidDismissBlock) (UIActionSheet *actionSheet, NSUInteger idx);
@interface UIActionSheet (PicaBlock) <UIActionSheetDelegate>
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle onClick: (ClickBlock) clickBlock onCancel: (CancelBlock) cancelBlock onWillDismiss: (WillDismissBlock) willDismissBlock onDidDismiss: (DidDismissBlock) didDismissBlock otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
@end
