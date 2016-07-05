//
//  ViewController.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListQuestionView.h"
#import "StackModel.h"
#import "QuestionsRow.h"



@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StackModelDelegate>

@property (nonatomic,strong) ListQuestionView *qnView;
@property (nonatomic,strong) StackModel *model;

@end

