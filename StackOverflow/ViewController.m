//
//  ViewController.m
//  StackOverflow
//
//  Created by Lakshmi Thulasiram on 03/07/16.
//  Copyright © 2016 Lakshmi Thulasiram. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSDictionary *questionsResponse;
@end

@implementation ViewController

-(void)loadView
{
    [super loadView];
    
    self.qnView = [[ListQuestionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.qnView.tableQn.delegate=self;
    self.qnView.tableQn.dataSource=self;
    self.view = self.qnView;
    
    [self.qnView.swipeableTabs addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    
    self.model = [[StackModel alloc] init];
    self.model.delegate=self;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.qnView.swipeableTabs selectElementwithTag:0];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-

-(void)segmentSelected:(SwipableTabs *)segment
{
    if(segment.selectedIndex == 0)
    {
        [self fetchQuestionsforSortCategory:@"activity"];
    }
    if(segment.selectedIndex == 1)
    {
        [self fetchQuestionsforSortCategory:@"hot"];
    }if(segment.selectedIndex == 2)
    {
        [self fetchQuestionsforSortCategory:@"votes"];
    }if(segment.selectedIndex == 3)
    {
        [self fetchQuestionsforSortCategory:@"week"];
    }
}

-(void)fetchQuestionsforSortCategory:(NSString *)sortCategory
{
    self.qnView.userInteractionEnabled = NO;
    self.qnView.alpha = 0.5f;
    
    Requestor *questionReq = [[Requestor alloc] init];
    questionReq.serviceName = @"questions";
    questionReq.method = @"GET";
    questionReq.parameters = [NSMutableDictionary dictionary];
    [questionReq.parameters setObject:@"asc" forKey:@"order"];
    [questionReq.parameters setObject:sortCategory forKey:@"sort"];
    [questionReq.parameters setObject:@"default" forKey:@"filter"];
    [questionReq.parameters setObject:@"stackoverflow" forKey:@"site"];
    
    [self.model sendRequest:questionReq];
}

-(void)handleResponse:(Response *)response
{
    self.qnView.userInteractionEnabled = YES;
    self.qnView.alpha = 1.0f;
    
    if([response.serviceName isEqualToString:@"questions"])
    {
        self.questionsResponse = response.responseObj;
        [self.qnView.tableQn reloadData];
        NSLog(@"%@",self.questionsResponse);
        
    }
}
-(NSDictionary *)getDataForRow:(int)row
{
   return  [[self.questionsResponse objectForKey:@"items"] objectAtIndex:row];
}

#pragma mark-

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.questionsResponse objectForKey:@"items"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionsRow *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[QuestionsRow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell populateData:[self getDataForRow:(int)indexPath.row]];
    return cell;
    
}



@end
