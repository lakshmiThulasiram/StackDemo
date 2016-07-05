//
//  Response.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 04/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject
@property (nonatomic,strong) NSDictionary *responseObj;
@property (nonatomic,strong) NSString *serviceName;
@end
