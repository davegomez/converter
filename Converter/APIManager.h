//
//  APIManager.h
//  Converter
//
//  Created by David Gómez on 10/21/14.
//  Copyright (c) 2014 Craft Inc. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface APIManager : AFHTTPRequestOperationManager

+ (APIManager *)sharedManager;

@end
