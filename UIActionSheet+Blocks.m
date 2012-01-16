//
//  UIActionSheet+Blocks.m
//
//  Created by Jason Dinh on 16/1/12.
//  Copyright (c) 2012 bathanh@gmail.com. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
static CancelBlock _cancelBlock;
static ClickBlock _clickBlock;
static WillDismissBlock _willDismissBlock;
static DidDismissBlock _didDismissBlock;
@implementation UIActionSheet (PicaBlock)

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle onClick: (ClickBlock) clickBlock onCancel: (CancelBlock) cancelBlock onWillDismiss: (WillDismissBlock) willDismissBlock onDidDismiss: (DidDismissBlock) didDismissBlock otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [self initWithTitle: title delegate: nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    [self setDelegate: self];
    if (self) {
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
    
    [self retain];
    return self;
}

- (void) actionSheetCancel:(UIActionSheet *)actionSheet {
    if (_cancelBlock) {
        _cancelBlock(actionSheet);
    }
    [_cancelBlock release];
    [self release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_clickBlock) {
        _clickBlock(actionSheet, buttonIndex);
    }
    [_clickBlock release];
    [self release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (_didDismissBlock) {
        _didDismissBlock(actionSheet, buttonIndex);
    }
    [_didDismissBlock release];
    [self release];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_willDismissBlock) {
        _willDismissBlock(actionSheet, buttonIndex);
    }
    [_willDismissBlock release];
    [self release];
}

@end
