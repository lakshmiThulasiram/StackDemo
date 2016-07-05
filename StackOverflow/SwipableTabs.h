//
//  SwipableTabs.h
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 05/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwipableTabsDataSource <NSObject>
@optional

@required


@end


@interface SwipableTabs : UIControl

-(id)initWithFrame:(CGRect)frame withElements:(NSArray *)elements;
-(void)selectElementwithTag:(int)tag;
@property (nonatomic,strong) NSArray *elements;
@property (nonatomic,assign) int selectedIndex;

@end
