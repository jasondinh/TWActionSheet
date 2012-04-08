#TWActionSheet

Block addition for TWActionSheet

##Usage

```objective-c
#import "TWActionSheet.h"
```

```objective-c
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle onClick: (ClickBlock) clickBlock onCancel: (CancelBlock) cancelBlock onWillDismiss: (WillDismissBlock) willDismissBlock onDidDismiss: (DidDismissBlock) didDismissBlock otherButtonTitles:(NSString *)otherButtonTitles, ...;
```

```objective-c
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

//to invoke delegate method - have to be called before the actionsheet is showed
- (void) setOnCancelHandler: (CancelBlock) cancelBlock;
- (void) setOnClickHandler: (ClickBlock) clickBlock;
- (void) setBeforeDismissHandler: (WillDismissBlock) willDismissBlock;
- (void) setAfterDismissHandler: (DidDismissBlock) didDismissBlock;
```

## License

Copyright (c) 2012 Jason Dinh Ba Thanh. This code is licensed under the [MIT License](http://github.com/xuki/UIActionSheet-Blocks/raw/master/LICENSE).