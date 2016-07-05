//
//  StackModel.m
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import "StackModel.h"

//https://api.stackexchange.com/docs/questions#order=asc&sort=votes&filter=default&site=stackoverflow
#define BASE_URL @"https://api.stackexchange.com/2.2/"
@implementation StackModel

-(void) sendRequest:(Requestor *)request
{
    
    NSString *urlToConnect = [NSString stringWithFormat:@"%@/%@?&",BASE_URL,request.serviceName];


    if([request.method isEqualToString:@"GET"])
    {

        int i=1;
        for (NSString *key in [request.parameters allKeys]) {
            NSString *filler = @"&";
            
            if(i==[[request.parameters allKeys] count])
            {
                filler = @"";
            }
            
            urlToConnect = [urlToConnect stringByAppendingString:[NSString stringWithFormat:@"%@=%@%@",key,[request.parameters objectForKey:key],filler]];
            i++;
        }
    }
    
    NSMutableURLRequest *therequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlToConnect]];
    [therequest setHTTPMethod:request.method];


//    [therequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [therequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [therequest setTimeoutInterval:30];
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 2
    
    // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    [[session dataTaskWithRequest:therequest completionHandler:^(NSData *data,
                                                                 NSURLResponse *response,
                                                                 NSError *error) {
        
        if (error)
        {
           
            
        }
        else
        {
            
            
            
            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&jsonError];
            Response *resp = [[Response alloc] init];
            resp.serviceName = request.serviceName;
            resp.responseObj = json;
            [self.delegate handleResponse:resp];
        }
        
    }] resume];
    

//        NSString *urlToConnect = @" ";
//        if([response.method isEqualToString:@"GET"])
//        {
//            urlToConnect = @"?";
//        }
//        int i=1;
//        for (GetParamsForURLTradeModelResponseParameters *param in response.parameters) {
//            NSString *filler=@"";
//            if(i<[response.parameters count])
//            {
//                filler = @"&";
//            }
//            urlToConnect = [urlToConnect stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",param.key,param.value]];
//            
//            i++;
//            
//        }
//
//    }
}

@end
