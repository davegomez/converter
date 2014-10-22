//  CoinPouch.m
//
//  Copyright (c) 2014 Craft Inc (http://craftinc.co)
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

#import "CoinPouch.h"
#import "APIManager.h"

@interface CoinPouch ()

@property (nonatomic, readonly) NSDictionary *coins;
@property (nonatomic, readonly) NSTimeInterval interval;

@end

@implementation CoinPouch

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self fetchDataWithCompletionBlock:^(BOOL success) {
            if (success) {
                NSLog(@"Connection Succeed");
            } else {
                NSLog(@"Connection Failed");
            }
        }];
    }
    
    return self;
}

- (void)fetchDataWithCompletionBlock: (void (^)(BOOL success))completion {
    [[APIManager sharedManager] GET:@"latest.json?app_id=8d42d42070c74c04921be6e339b529b0"
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                // Fill the pouch dictionary with all the available currencies
                                _coins = [responseObject objectForKey:@"rates"];
                                completion(YES);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                // Error handling
                                NSLog(@"Error: %@", error);
                                completion(NO);
                            }];
}

- (NSDecimalNumber *)convertWith:(NSString *)value for:(NSString *)code {
    NSDecimalNumber *multiplier = [NSDecimalNumber decimalNumberWithString:value];
    
    NSString *currencyValueString = [NSString stringWithFormat:@"%@", _coins[code]];
    NSDecimalNumber *currencyValue = [NSDecimalNumber decimalNumberWithString:currencyValueString];
    
    return [currencyValue decimalNumberByMultiplyingBy:multiplier];
}

@end
