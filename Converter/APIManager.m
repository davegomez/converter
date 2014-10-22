//
//  APIManager.m
//  Converter
//
//  Created by David Gómez on 10/21/14.
//  Copyright (c) 2014 Craft Inc. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation APIManager

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

+ (APIManager *)sharedManager {
    static dispatch_once_t pred;
    static APIManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://openexchangerates.org/api/"]];
    });
    
    return _sharedManager;
}



@end
