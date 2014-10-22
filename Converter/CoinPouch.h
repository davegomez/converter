//  CoinPouch.h
//
//  Copyright (c) 2013-2014 Craft Inc (http://craftinc.co)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

/**
 `CoinPouch` is a subclass of NSObject with convenience methods to create currency data stores, fetch currency data from API, and compute currency values to convert a given currency amount.
 */

@interface CoinPouch : NSObject

///---------------------
/// @name Initialization
///---------------------

/**
 Creates and returns an `CoinPouch` object.
 */
- (instancetype)init;

///--------------------
/// @name Fetching Data
///--------------------

/**
 Connects to Open Exchange Rates REST API (https://openexchangerates.org/) to fetch the latest currency data in their database, then populates the coins object with all the country currency codes and they respective value, and finally returns a completion event to know if the connection and data fetching was successful or not.
 
 @param completion block to handle succeed and failed connections.
 */
- (void)fetchDataWithCompletionBlock: (void (^)(BOOL success))completion;

///------------------------
/// @name Data Manipulation
///------------------------

/**
 Takes the input value or the given amount to convert to the new currency value using the country code selected on the segmented control by multiplying both values.
 
 @param value or amount to convert to the new currency
 @param country code for the new currency
 
 @return the decimal value for the amount multiplied by the new currency value
 */
- (NSDecimalNumber *)convertWith:(NSString *)value for:(NSString *)code;

@end
