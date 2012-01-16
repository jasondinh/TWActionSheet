#UIActionSheet+Blocks

Block addition for UIActionSheet

##Usage

```objective-c
#import "UIActionSheet+Blocks.h"
```

```objective-c
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle onClick: (ClickBlock) clickBlock onCancel: (CancelBlock) cancelBlock onWillDismiss: (WillDismissBlock) willDismissBlock onDidDismiss: (DidDismissBlock) didDismissBlock otherButtonTitles:(NSString *)otherButtonTitles, ...
```

## License

Copyright (c) 2012 Jason Dinh Ba Thanh. This code is licensed under the [MIT License](http://github.com/xuki/UIActionSheet-Blocks/raw/master/LICENSE).