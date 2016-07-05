//
//  StackModel.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Requestor.h"
#import "Response.h"

@protocol StackModelDelegate <NSObject>

-(void)handleResponse:(Response *)response;


@end

@interface StackModel : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate>
-(void) sendRequest:(Requestor *)request;

@property (nonatomic,weak) id<StackModelDelegate> delegate;
@end
