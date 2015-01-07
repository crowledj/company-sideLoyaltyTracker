//
//  searchNameView.m
//  GoldenScissors
//
//  Created by EventHorizon on 03/01/2015.
//  Copyright (c) 2015 EventHorizon. All rights reserved.
//

#import "searchNameView.h"

@interface searchNameView ()
{
    sqlite3 *db;
}
@end

@implementation searchNameView



- (void)viewDidLoad {

    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    
    self->removeBox.delegate = self;
    self->tableName= @"CustomerCard";
    
    
    /*
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 200)];
    // Do some stuff
    [self.view addSubview:label];
    */
    
    
    /*
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    label.textColor=[UIColor whiteColor];
    label.text = @" PDF";
    [self.view addSubview:label];
    */
    
    
    
    //open/create database
    int result = sqlite3_open([[self filePath] UTF8String],&db);
    
    if(result != SQLITE_OK)
        NSLog(@"Error : database not opened or created in %@ ",[self filePath]);
    
}


-(NSString *) filePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDir = [paths lastObject];
    
    
    return[documentsDir stringByAppendingPathComponent:@"NewLoyaltyCard.sql"];
}


-(IBAction)namePressed:(UIButton *)sender
{
    NSString *name = (NSString *)(sender.currentTitle);
    NSString *removeField = removeBox.text;
    
    UIAlertView *alertMsg=nil;
    
    sqlite3_stmt /**statement,*/*statement_1;
    
    NSLog(@"in button preseed func of new view ! :)");
    
    //***************************     TEST    **************************************
    
    NSString *insQL = [NSString stringWithFormat:
                       @"select * from CustomerCard where customerName= \"%@\" ",removeField];
    
    const char *stmt = [insQL UTF8String];
    
    
    
    if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK) {
        
         NSLog(@"processing select statement correctly  :)-- SQL string = %@ ",insQL);
        
        while(sqlite3_step(statement_1) == SQLITE_ROW) {
            
             NSLog(@"going thru rows. ");
            
            NSLog(@"Read rows OK");
            NSString *dbMessageID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 0)];
            NSString *dbMessageText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 1)];
            int dbMessageDate = (int )sqlite3_column_int(statement_1, 2);
            count= (int )sqlite3_column_int(statement_1, 0);
            
            NSLog(@"code = %@ -- name = %@ -- counter = %d",dbMessageID,dbMessageText,dbMessageDate);

            
        }
    }
    
    else NSLog(@"Something fucked up here  :( ");
    
    
    sqlite3_finalize(statement_1);
    
    //***************************   END  TEST    ***************************************
    
    NSString *countString=nil;
    
    NSLog(@"count = %d ",count);
    
    
    if(count == 0){
        countString= @"0";
        [self alert:alertMsg PopupWith:countString];
    }
    
    else if(count == 1){
        countString= @"1";
        [self alert:alertMsg PopupWith:countString];
    }
    
    else if(count == 2){
        countString= @"2";
        [self alert:alertMsg PopupWith:countString];
    }
    
    else if(count == 3){
        countString= @"3";
        [self alert:alertMsg PopupWith:countString];
    }
    
    else if(count == 4){
        countString= @"4";
        [self alert:alertMsg PopupWith:countString];
    }
    
    else if(count == 5){
        countString= @"5";
        [self alert:alertMsg PopupWith:countString];
        //reset count.
        count=0;
        //[self resetRecordInTableNamed:tableName
                     // withSearchField:searchField];
    }
}



-(void) alert:(UIAlertView *) alert PopupWith: (NSString *) counter
{
    
    NSString *extraStuff_2 = @"\n Customer with card code : ";
    NSString *extraStuff_3=nil;
    extraStuff_3 = [extraStuff_2 stringByAppendingString:counter];
    
    
    //display message for customer count no.
    
    if(count < 5 )
        
        alert = [[UIAlertView alloc] initWithTitle:@"Customer card incremented"
                                           message: extraStuff_3
                                          delegate:nil cancelButtonTitle:@"OK I get it ! :)"
                                 otherButtonTitles:nil];
    
    else
        alert = [[UIAlertView alloc] initWithTitle:@"Customer card incremented"
                                           message: extraStuff_3
                                          delegate:nil cancelButtonTitle:@"REWARD THE CUSTOMER :) --\n RESETTING REWARD COUNT TO ZERO "
                                 otherButtonTitles:nil];
    
    [alert show];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
