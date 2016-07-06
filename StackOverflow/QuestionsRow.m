//
//  QuestionsRow.m
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 04/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import "QuestionsRow.h"
#define TAG_BASE 200
@implementation QuestionsRow

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        if(!self.labelQnTitle)
        {
            [self createViews];
        }
    }
    return self;
}
-(void)createViews
{
    int offsetX = 5;
    int offsetY =5;
    self.labelQnTitle = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, self.frame.size.width, 40)];
    self.labelQnTitle.lineBreakMode=NSLineBreakByWordWrapping;
    self.labelQnTitle.numberOfLines=0;
    self.labelQnTitle.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:self.labelQnTitle];
    
    offsetY += self.labelQnTitle.frame.size.height;
    
    self.labelPosterName = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, self.frame.size.width *0.9, 20)];
    self.labelPosterName.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.labelPosterName];
    
    offsetX = self.frame.size.width - 30;
    int width = 25;
    self.labelVotes = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, width, 20)];
    self.labelVotes.layer.cornerRadius = width/2;
    self.labelVotes.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.labelVotes.layer.backgroundColor = [UIColor yellowColor].CGColor;
    self.labelVotes.textAlignment = NSTextAlignmentCenter;
    self.labelVotes.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:self.labelVotes];
    
    
    
    
    
}
-(void)populateData:(NSDictionary *)data
{
    
    self.labelQnTitle.text = [data objectForKey:@"title"];
    self.labelVotes.text = [[data
                            objectForKey:@"score"] stringValue];
    
    
    //
    self.labelPosterName.text = [NSString stringWithFormat:@"Asked by: %@ on %@",[[data objectForKey:@"owner"] objectForKey:@"display_name"],[self convertEpochTimeToDate:[[data objectForKey:@"creation_date"] stringValue]]];
    [self createTagContainerWithData:[data objectForKey:@"tags"]];
    
    
}
-(void)createTagContainerWithData:(NSArray *)tags

{
    if(!self.viewTagHolder)
    {
        self.viewTagHolder = [[UIView alloc] initWithFrame:CGRectMake(0, self.labelVotes.frame.origin.y + self.labelVotes.frame.size.height, self.frame.size.width, 30)];
        [self addSubview:self.viewTagHolder];
        
    }
    
    self.viewTagHolder.backgroundColor = [UIColor clearColor];
    
    int offsetX=5;
    int offsetY=0;
    int labelHgt = 20;
    int i=0;
    for (UIView *view in self.viewTagHolder.subviews) {
        [view removeFromSuperview];
    }
    for(NSString *title in tags)
    {
        float labelWidth = [title sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(9999,9999)].width;
        if(offsetX + labelWidth +5 > [[UIScreen mainScreen] bounds].size.width)
        {
            offsetX = 5;
            offsetY += labelHgt;
        }
        

        UILabel *label= [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        label.layer.cornerRadius = 2.0f;
        label.tag = TAG_BASE +i;
        [self.viewTagHolder addSubview:label];

        label.frame =CGRectMake(offsetX, offsetY, labelWidth, labelHgt);
        label.text = title;
        
        offsetX += labelWidth + 5 ;
        i++;
        
    }
    
    
}
-(NSString*)convertEpochTimeToDate:(NSString *)epochTime
{
    double epochTimeinDouble = [epochTime doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    if([[NSLocale availableLocaleIdentifiers] indexOfObject:@"en_IN"] != NSNotFound)
    {
        NSLocale *loc = [[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"];
        [dateFormatter setLocale: loc];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(int)(epochTimeinDouble)];
    
    NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
    [outputFormat setDateFormat:@"dd MMM yyyy"];
    NSString *outputDateString = [outputFormat stringFromDate:date];
    return outputDateString;

}

@end
