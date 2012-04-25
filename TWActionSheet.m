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
    ARC_DEALLOC(super);
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
    if (cancelBlock != _cancelBlock) {
        ARC_RELEASE(_cancelBlock);
        _cancelBlock = [cancelBlock copy];
    }
}

- (void) setClickBlock: (ClickBlock) clickBlock {
    if (clickBlock != _clickBlock) {
        ARC_RELEASE(_clickBlock);
        _clickBlock = [clickBlock copy];
    }
}
- (void) setWillDismissBlock: (WillDismissBlock) willDismissBlock {
    if (willDismissBlock != _willDismissBlock) {
        ARC_RELEASE(_willDismissBlock);
        _willDismissBlock = [willDismissBlock copy];
    }    
}
- (void) setDidDismissBlock: (DidDismissBlock) didDismissBlock {
    if (didDismissBlock != _didDismissBlock) {
        ARC_RELEASE(_didDismissBlock);
        _didDismissBlock = [didDismissBlock copy];
    }
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [self initWithTitle: title delegate: nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    if (self) {
        __block TWActionSheet *blockSelf = self;
        [self setDelegate: blockSelf];
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
    return self;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle onClick: (ClickBlock) clickBlock onCancel: (CancelBlock) cancelBlock onWillDismiss: (WillDismissBlock) willDismissBlock onDidDismiss: (DidDismissBlock) didDismissBlock otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [self initWithTitle: title delegate: nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    if (self) {
        __block TWActionSheet *blockSelf = self;
        [self setDelegate: blockSelf];
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
    return self;
}

- (void) actionSheetCancel:(UIActionSheet *)actionSheet {
    if (_cancelBlock) {
        _cancelBlock(actionSheet);
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_clickBlock) {
        _clickBlock(actionSheet, buttonIndex);
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (_didDismissBlock) {
        _didDismissBlock(actionSheet, buttonIndex);
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_willDismissBlock) {
        _willDismissBlock(actionSheet, buttonIndex);
    }
}
@end