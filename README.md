# XyzCustomKeyBoard

[![CI Status](https://img.shields.io/travis/albert_xyz@163.com/XyzCustomKeyBoard.svg?style=flat)](https://travis-ci.org/albert_xyz@163.com/XyzCustomKeyBoard)
[![Version](https://img.shields.io/cocoapods/v/XyzCustomKeyBoard.svg?style=flat)](https://cocoapods.org/pods/XyzCustomKeyBoard)
[![License](https://img.shields.io/cocoapods/l/XyzCustomKeyBoard.svg?style=flat)](https://cocoapods.org/pods/XyzCustomKeyBoard)
[![Platform](https://img.shields.io/cocoapods/p/XyzCustomKeyBoard.svg?style=flat)](https://cocoapods.org/pods/XyzCustomKeyBoard)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XyzCustomKeyBoard is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XyzCustomKeyBoard'
```

## Usage
``` ruby
UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 280, 40)];
textField.backgroundColor = [UIColor yellowColor];
[self.view addSubview:textField];

CustomKeyBoard *customKeyBoard = [[CustomKeyBoard alloc] initWithFrame:CGRectZero textField:textField];
textField.inputView = customKeyBoard;
```
## Result
![](https://github.com/AlbertXYZ/XyzCustomKeyBoard/raw/master/gif008.gif)

## Author
albert_xyz@163.com, 小徐

## License

XyzCustomKeyBoard is available under the MIT license. See the LICENSE file for more info.
