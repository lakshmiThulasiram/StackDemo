//
//  Requestor.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Requestor : NSObject
@property (nonatomic,strong) NSMutableDictionary *parameters;
@property (nonatomic,strong) NSString *serviceName;
@property (nonatomic,strong) NSString *method;

@end
