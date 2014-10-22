//
//  ListVC.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "ListVC.h"
#import "UIColor+JSONInitializer.h"
#import "ArrayDataSource.h"
#import "ListCell.h"
#import "DetailVC.h"

@interface ListVC () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) ArrayDataSource *arrayDataSource;

@end

@implementation ListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialSetup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)initialSetup
{
    //Load local list
    NSString *listPath = [[NSBundle mainBundle] pathForResource:@"LocalResources/list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:listPath];
    NSArray *dataArray = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] objectForKey:@"data"];
    
    
    self.arrayDataSource = [[ArrayDataSource alloc] initWithArray:dataArray configureCellBlock:^(id cell, id item) {
        //This block will be called for each cell and should be used to configure its information
        ListCell *tableCell = cell;
        [tableCell configureForTitle:item[@"title"] andColor:[UIColor colorWithJSONParsedDict:item[@"color"]]];
    }];
    
    //Setup TableView
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setEstimatedRowHeight:50];
    [self.tableView setRowHeight:UITableViewAutomaticDimension]; //required for auto-sizing cells
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ListCell"];
    [self.tableView setDataSource:self.arrayDataSource];
    
    
    [self.tableView setDelegate:self];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"toDetailVC" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailVC *destination = segue.destinationViewController;
    
    destination.arrayDataSource = self.arrayDataSource;
    destination.detailPosition = [sender row];
    destination.detailColor = [UIColor colorWithJSONParsedDict:[self.arrayDataSource dataAtIndexPath:sender][@"color"]];
}



@end
