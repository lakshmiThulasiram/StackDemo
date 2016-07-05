//
//  QuestionsRow.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 04/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsRow : UITableViewCell

@property (nonatomic,strong) UILabel *labelQnTitle;
@property (nonatomic,strong) UILabel *labelVotes;
@property (nonatomic,strong) UILabel *labelPosterName;
@property (nonatomic,strong) UILabel *labelTimeStamp;
@property (nonatomic,strong) UIView *viewTagHolder;

-(void)populateData:(NSDictionary *)data;
@end
