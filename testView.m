//
//  testView.m
//  GoldenScissors
//
//  Created by EventHorizon on 04/01/2015.
//  Copyright (c) 2015 EventHorizon. All rights reserved.
//

#import "testView.h"

@interface testView ()
{
    sqlite3 *db;
}
@end

@implementation testView

- (void)viewDidLoad {
    
    
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    contentView.backgroundColor = [UIColor whiteColor];
    self.view = contentView;
    
    
    //add page label
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor=[UIColor blackColor];
    label.text = @"Search Database by Customer";
    [self.view addSubview:label];
    
    //add labels for results :
    UILabel  *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 125, 35)];
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    codeLabel.textColor=[UIColor blackColor];
    codeLabel.text = @"Unique Code :";
    [codeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:codeLabel];
    
    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 250, 125, 35)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.text = @"Customer Name :";
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:nameLabel];
    
    
    UILabel  *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 250, 125, 35)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textAlignment = NSTextAlignmentLeft;
    countLabel.textColor=[UIColor blackColor];
    countLabel.text = @"Haircut no.:";
    [countLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:countLabel];
    
    
    /*
    searchbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchbutton addTarget:self
               action:@selector(namePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [searchbutton setTitle:@"Show View" forState:UIControlStateNormal];
    searchbutton.frame = CGRectMake(50.0, 200.0, 100.0, 50.0);
    [self.view addSubview:searchbutton];
    
    
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(80 ,150, 100, 70)];
    tf.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    tf.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    tf.backgroundColor=[UIColor whiteColor];
    tf.text=@"Hello";
    
    self->tf.delegate = self;
    */
    
    /**** test parameters  ***/
    
    searchbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchbutton addTarget:self
                     action:@selector(namePressed:)
           forControlEvents:UIControlEventTouchUpInside];
    [searchbutton setTitle:@"Show View" forState:UIControlStateNormal];
    searchbutton.frame = CGRectMake(125.0, 200.0, 100.0, 50.0);
    [self.view addSubview:searchbutton];
    
    
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(125 ,125, 100, 25)];
    tf.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    tf.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    tf.backgroundColor=[UIColor whiteColor];
    
    [tf.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [tf.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    tf.layer.cornerRadius = 5;
    tf.clipsToBounds = YES;
    
    tf.text=@"Hello";
    
    self->tf.delegate = self;
    
    
    [self.view addSubview:tf];
    
    
    //open/create database
    int result = sqlite3_open([[self filePath] UTF8String],&db);
    
    if(result != SQLITE_OK)
        NSLog(@"Error : database not opened or created in %@ ",[self filePath]);
    
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)namePressed:(UIButton *)sender
{
    //NSString *string=nil;
    NSLog(@"Activated button function ! :) ");
    
    NSString *searchField = tf.text;
    UIAlertView *alertMsg=nil;
    
    sqlite3_stmt *statement_1;
    
    NSLog(@"in button preseed func of new view ! :)");
    
    //***************************     TEST    **************************************
    
    NSString *insQL = [NSString stringWithFormat:
                       @"select * from CustomerCard where customerName = \"%@\" ",searchField];
    
    const char *stmt = [insQL UTF8String];
    
    
    if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK) {
        
        NSLog(@"processing select statement correctly  :)-- SQL string = %@ ",insQL);
        
        while(sqlite3_step(statement_1) == SQLITE_ROW) {
            
            NSLog(@"going thru rows. ");
            
            NSLog(@"Read rows OK");
            NSString *dbMessageID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 0)];
            NSString *dbMessageText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 1)];
            int dbMessageDate = (int )sqlite3_column_int(statement_1, 2);
            
            NSString *dbCounterText = [self intToString:dbMessageDate];
            
            NSLog(@"code = %@ -- name = %@ -- counter = %d",dbMessageID,dbMessageText,dbMessageDate);
            
            //(20, 250, 125, 35)
            UILabel  * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 275, 125, 35)];
            label_1.backgroundColor = [UIColor clearColor];
            label_1.textAlignment = NSTextAlignmentLeft;
            label_1.textColor=[UIColor blackColor];
            label_1.text = dbMessageID;
            [self.view addSubview:label_1];
            
            
            //(120, 250, 125, 35)
            UILabel  * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 275,125, 35)];
            label_2.backgroundColor = [UIColor clearColor];
            label_2.textAlignment = NSTextAlignmentLeft;
            label_2.textColor=[UIColor blackColor];
            label_2.text = dbMessageText;
            [self.view addSubview:label_2];
            
            
            //(240, 250, 125, 35)
            UILabel  * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 275, 125, 35)];
            label_3.backgroundColor = [UIColor clearColor];
            label_3.textAlignment = NSTextAlignmentLeft;
            label_3.textColor=[UIColor blackColor];
            label_3.text = dbCounterText;
            [self.view addSubview:label_3];
            
            
            
        }
    }
    
    else NSLog(@"Something fucked up here  :( ");
    sqlite3_finalize(statement_1);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(NSString *) filePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDir = [paths lastObject];
    
    
    return[documentsDir stringByAppendingPathComponent:@"NewLoyaltyCard.sql"];
}


- (NSString *) intToString:(int)count
{

    NSString *countString=nil;


    if(count == 0){
        countString= @"0";
          }

    else if(count == 1){
        countString= @"1";
            }

    else if(count == 2){
        countString= @"2";
       
    }

    else if(count == 3){
        countString= @"3";
    
    }

    else if(count == 4){
        countString= @"4";
    }

    else if(count == 5){
        countString= @"5";
    }

    return countString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
