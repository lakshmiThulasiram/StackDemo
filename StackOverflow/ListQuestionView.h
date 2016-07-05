//
//  ListQuestionView.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipableTabs.h"

@interface ListQuestionView : UIView
@property (nonatomic,strong) SwipableTabs *swipeableTabs;

@property (nonatomic,strong) UITableView *tableQn;
@end
