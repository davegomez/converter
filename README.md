# HUGE iOS Coding Challenge
## Currency Converter

![Currency Converter](https://raw.githubusercontent.com/davegomez/converter/master/currency-converter.png)

## Requirements

- Ruby 2.0 or later
- Cocoapods Gem (Ruby)
- Xcode 6
- iOS 7.1 or later

## Instalation

Clone the repository into the desired directory.

    git clone https://github.com/davegomez/converter.git && cd converter
    
Install Cocoapods and library dependencies.

    gem install cocoapods && pod install

Open the project with **Xcode 6** (or later) using the ```Converter.xcworkspace``` file and build with any device.

## Usage

Insert the amount of US Dollars you want to convert, you can only use whole integers or integers with decimal parts (eg. 15 or 23.68), choose the desired currency (Great Britain Pound by default), press the Convert button.

You can change the amount and the desired currency at any moment.

## Caveats

There is not sanity checking for the text field, so if you type anything different from the expected numbers the app may crash.

## The MIT License (MIT)

Copyright (c) 2014 [Craft Inc](http://craftinc.co)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
