//
//  CoinPouch.h
//  Converter
//
//  Created by David Gómez on 10/21/14.
//  Copyright (c) 2014 Craft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinPouch : NSObject

- (instancetype)initWithCompletionBlock:(void (^)(BOOL success))completion;
- (NSDecimalNumber *)convertWith:(NSString *)value for:(NSString *)code;

@end
