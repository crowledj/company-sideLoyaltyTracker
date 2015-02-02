//
//  TableViewController.m
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "secondView.h"
#import "searchNameView.h"
#import "testView.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize arrItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[UIApplication sharedApplication] keyWindow].tintColor = [UIColor orangeColor];
    
    arrItems = [[NSArray alloc] initWithObjects:@"Add new customer's card",@"Add point to card",@"Remove a card by customer code",@"Search a card by customer name", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [arrItems count];
}


  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [arrItems objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        ViewController *detailViewController_1 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:detailViewController_1 animated:YES];
    
    }
    
    else if(indexPath.row == 1)
    {
        secondView *detailViewController_2 = [[secondView alloc] initWithNibName:@"secondView" bundle:nil];
        [self.navigationController pushViewController:detailViewController_2 animated:YES];
    }
    
    else if(indexPath.row == 2)
    {
        searchNameView *detailViewController_3 = [[searchNameView alloc] initWithNibName:@"searchNameView" bundle:nil];
        [self.navigationController pushViewController:detailViewController_3 animated:YES];
    }
    
    else
    {
        testView *detailViewController_4 = [[testView alloc] initWithNibName:@"testView" bundle:nil];
        [self.navigationController pushViewController:detailViewController_4 animated:YES];
    }

}



@end
