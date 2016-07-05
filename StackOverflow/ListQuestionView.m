//
//  ListQuestionView.m
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import "ListQuestionView.h"
#define CLIENT_ID 7416
@implementation ListQuestionView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createView];
    }
    return self;
}
-(void)createView
{
    int offsetY=20;
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, offsetY, 100, 20)];
    [btnLogin setTitle:@"Sign in" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnLogin];
    
    offsetY+= btnLogin.frame.size.height+10;
       
    self.swipeableTabs = [[SwipableTabs alloc] initWithFrame:CGRectMake(0, offsetY, self.frame.size.width,30) withElements:@[@"ACTIVITY",@"HOT",@"VOTES",@"WEEK",@"MONTH"]];
    [self addSubview:self.swipeableTabs];
    
    
    offsetY+= self.swipeableTabs.frame.size.height+5;

    self.backgroundColor = [UIColor whiteColor];
    self.tableQn = [[UITableView alloc] initWithFrame:CGRectMake(0, offsetY, self.frame.size.width, self.frame.size.height -offsetY) style:UITableViewStylePlain];
    self.tableQn.backgroundColor=[UIColor clearColor];
    [self addSubview:self.tableQn];
}
-(void)signIn
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?&client_id=7425&scope=no_expiry&redirect_uri=stackdemoApp://"]];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?&client_id=7425&scope=no_expiry&redirect_uri=stackdemoApp:/"]];

  
}
@end
