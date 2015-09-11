# JFFontObserver
JFFontObserver is used to update fonts and / or UI when a user changes their device font. It uses a simple observer approach to run font and / or UI update blocks.

##Purpose
The main purpose of this software is to provide developers with a simple way to add non-intrusive dynamic font support for applications.

##Installation
Install via CocoaPods
Add the following line to your .podfile

```
pod 'JFFontObserver'
```
##Support
####IOS
Earliest tested and supported build and deployment target - iOS 6.0. 
Latest tested and supported build and deployment target - iOS 8.4.

##ARC Compatibility
JFFontObserver is built from ARC and is ARC-only compatible. 

##Usage
####JFFontObserver initialization
Simply import the font observer class.
``` objective-c
#import <JFFontObserver/JFFontObserver.h>
``` 

####JFFontObserver usage
Add anything that needs updating to a font update block and it will be called upon system font size changes and, optionally, right away.
``` objective-c
typeof(self) __weak weakSelf = self;
[JFFontObserver addObserver:self fontUpdateBlock:^{

    weakSelf.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

} updateImmediatly:YES];
``` 