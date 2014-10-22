//
//  CoinPouch.m
//  Converter
//
//  Created by David Gómez on 10/21/14.
//  Copyright (c) 2014 Craft Inc. All rights reserved.
//

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
    // Fetch the currency data from the Open Exchange Rates REST API
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

// Takes the value to convert and the country code, computes the value,
// and return the output as decimal number
- (NSDecimalNumber *)convertWith:(NSString *)value for:(NSString *)code {
    NSDecimalNumber *multiplier = [NSDecimalNumber decimalNumberWithString:value];
    
    NSString *currencyValueString = [NSString stringWithFormat:@"%@", _coins[code]];
    NSDecimalNumber *currencyValue = [NSDecimalNumber decimalNumberWithString:currencyValueString];
    
    return [currencyValue decimalNumberByMultiplyingBy:multiplier];
}

@end
