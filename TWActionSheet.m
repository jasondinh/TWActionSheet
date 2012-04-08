//
//  UIActionSheet+Blocks.m
//
//  Created by Jason Dinh on 16/1/12.
//  Copyright (c) 2012 bathanh@gmail.com. All rights reserved.
//

#import "TWActionSheet.h"
@implementation TWActionSheet: UIActionSheet

- (void) dealloc {
ARC_RELEASE(_cancelBlock);
ARC_RELEASE(_clickBlock);
ARC_RELEASE(_willDismissBlock);
ARC_RELEASE(_didDismissBlock);
[super dealloc];
}

- (CancelBlock) cancelBlock {
    return _cancelBlock;
}

- (ClickBlock) clickBlock {
    return _clickBlock;
}

- (WillDismissBlock) willDismissBlock {
    return _willDismissBlock;
}

- (DidDismissBlock) didDismissBlock {
    return _didDismissBlock;
}

- (void) setCancelBlock: (CancelBlock) cancelBlock {
    ARC_RELEASE(_cancelBlock);
    _cancelBlock = [cancelBlock copy];
}
- (void) setClickBlock: (ClickBlock) clickBlock {
    ARC_RELEASE(_clickBlock);
    _clickBlock = [clickBlock copy];
}
- (void) setWillDismissBlock: (WillDismissBlock) willDismissBlock {
    ARC_RELEASE(_willDismissBlock);
    _willDismissBlock = [willDismissBlock copy];
    
}
- (void) setDidDismissBlock: (DidDismissBlock) didDismissBlock {
    ARC_RELEASE(_didDismissBlock);
    _didDismissBlock = [didDismissBlock copy];
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [self initWithTitle: title delegate: nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    if (self) {
        [self setDelegate: self];
        va_list argumentList;
        if (otherButtonTitles) {
            NSMutableArray *buttons = [NSMutableArray array];
            [buttons addObject: otherButtonTitles];
            
            va_start(argumentList, otherButtonTitles);
            NSString *eachItem;
            while((eachItem = va_arg(argumentList, NSString *))) {
                [buttons addObject: eachItem];
            }
            va_end(argumentList);
            [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self addButtonWithTitle: obj];
            }];
            
        }
    }
    ARC_RETAIN(self);
    return self;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle onClick: (ClickBlock) clickBlock onCancel: (CancelBlock) cancelBlock onWillDismiss: (WillDismissBlock) willDismissBlock onDidDismiss: (DidDismissBlock) didDismissBlock otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [self initWithTitle: title delegate: nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    if (self) {
        [self setDelegate: self];
        va_list argumentList;        
        if (otherButtonTitles) {
            NSMutableArray *buttons = [NSMutableArray array];
            [buttons addObject: otherButtonTitles];
            
            va_start(argumentList, otherButtonTitles);
            NSString *eachItem;
            while((eachItem = va_arg(argumentList, NSString *))) {
                [buttons addObject: eachItem];
            }
            va_end(argumentList);
            [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self addButtonWithTitle: obj];
            }];
            
        }        
        if (cancelBlock) {
            _cancelBlock = [cancelBlock copy];
        }        
        if (clickBlock) {
            _clickBlock = [clickBlock copy];
        }        
        if (didDismissBlock) {
            _didDismissBlock = [didDismissBlock copy];
        }        
        if (willDismissBlock) {
            _willDismissBlock = [willDismissBlock copy];
        }
    }
    
    ARC_RETAIN(self);
    return self;
}

- (void) actionSheetCancel:(UIActionSheet *)actionSheet {
    if (_cancelBlock) {
        _cancelBlock(actionSheet);
    }
    ARC_RELEASE(_cancelBlock);
    ARC_RELEASE(self);
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_clickBlock) {
        _clickBlock(actionSheet, buttonIndex);
    }
    ARC_RELEASE(_clickBlock);
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (_didDismissBlock) {
        _didDismissBlock(actionSheet, buttonIndex);
    }
    ARC_RELEASE(_didDismissBlock);
    ARC_RELEASE(self);
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_willDismissBlock) {
        _willDismissBlock(actionSheet, buttonIndex);
    }
    ARC_RELEASE(_willDismissBlock);
}

@end