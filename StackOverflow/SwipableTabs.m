//
//  SwipableTabs.m
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 05/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import "SwipableTabs.h"
#define DEFAULT_WIDTH 100
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface SwipableTabs()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *holderView;

@end
@implementation SwipableTabs

-(id)initWithFrame:(CGRect)frame withElements:(NSArray *)elements
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.elements = elements;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
       
        [self addSubview:self.scrollView];
        self.scrollView.scrollEnabled=NO;
        
        self.holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.holderView.layer.borderColor = UIColorFromRGB(0x1476FF).CGColor; //[UIColor blueColor].CGColor;
        self.holderView.layer.cornerRadius = 2.0f;
        self.holderView.layer.borderWidth=1.0f;
        [self.scrollView addSubview:self.holderView];
        
        UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.holderView addGestureRecognizer:leftGesture];
        
        UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.holderView addGestureRecognizer:rightGesture];
        
        
        
        
        int offsetX=0;
        for (int index=0; index<[elements count]; index++)
        {
            float labelWidth = [[self.elements objectAtIndex:index] sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(9999,9999)].width + 10;
            
            if(labelWidth < DEFAULT_WIDTH)
            {
                labelWidth = DEFAULT_WIDTH;
            }
            UILabel* titleView=  [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, labelWidth, 30)];
            titleView.backgroundColor=[UIColor clearColor];
            titleView.font = [UIFont systemFontOfSize:16];
            titleView.userInteractionEnabled=YES;
            titleView.textAlignment = NSTextAlignmentCenter;
            titleView.text = [self.elements objectAtIndex:index];
            UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topScrollViewTapped:)];
            tapGesture.numberOfTapsRequired=1;
            titleView.tag = index;
            [titleView addGestureRecognizer:tapGesture];
            [self.holderView addSubview:titleView];
            
            UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(titleView.frame.size.width-1, 0, 1, titleView.frame.size.height)];
            sep.backgroundColor =  UIColorFromRGB(0x1476FF);
            [titleView addSubview:sep];
            
            offsetX +=labelWidth;
        
        }
        
        self.scrollView.contentSize = CGSizeMake(offsetX, self.frame.size.width);
        CGRect rect = self.holderView.frame;
        rect.size.width = offsetX;
        self.holderView.frame = rect;
        if(offsetX < self.frame.size.width)
        {
            
        }
        

    }
    [self selectElementwithTag:0];
    return self;
    
}


-(void)selectElementwithTag:(int)tag
{
    self.selectedIndex =tag;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    for (UIView *view in self.holderView.subviews) {
        if(tag == view.tag)
        {
            view.backgroundColor =  UIColorFromRGB(0x1476FF) ;
            

        }
        else
        {
            view.backgroundColor = [UIColor whiteColor] ;

        }

    }
    
    UILabel *label = (UILabel *)[self viewWithTag:tag];
    
    if(self.holderView.frame.size.width > self.frame.size.width)
    {
        int remaingWidth = self.holderView.frame.size.width - label.frame.origin.x;
        if((label.frame.origin.x/2 + label.frame.size.width) + remaingWidth > self.holderView.frame.size.width)
        {
            [self.scrollView setContentOffset:CGPointMake(label.frame.origin.x/2, 0)];
            
        }
        else{
            [self.scrollView setContentOffset:CGPointMake(self.holderView.frame.size.width - self.frame.size.width, 0)];
        }
    }

    
    
    
}
-(void)topScrollViewTapped:(UITapGestureRecognizer *)recognizer
{
    [self selectElementwithTag: recognizer.view.tag];
}
-(void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    if(gesture.direction ==  UISwipeGestureRecognizerDirectionRight)
    {
        if (self.selectedIndex != 0) {
            [self selectElementwithTag: self.selectedIndex -1];

           
        }
    }
    if(gesture.direction ==  UISwipeGestureRecognizerDirectionLeft)
    {
        if (self.selectedIndex != [self.elements count]-1) {
            [self selectElementwithTag: self.selectedIndex +1];
            
            
        }
    }
}
@end
