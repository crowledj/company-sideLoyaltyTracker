//
//  secondView.m
//  GoldenScissors
//
//  Created by EventHorizon on 21/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "secondView.h"

@interface secondView ()
{
    sqlite3 *db;
}
@end

@implementation secondView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self->codeBox.delegate = self;
    self->tableName= @"CustomerCard";
    
    self.title = @"Add Point to card";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Fiber-Carbon-Tiled-Pattern-background-vol.11.jpg"]];
    
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
    NSString *searchField = codeBox.text;
    
    UIAlertView *alertMsg=nil;
    
    sqlite3_stmt *statement_1;
        
    [self totUpRecordInTableNamed:tableName withSearchField:searchField];

    //***************************     TEST    **************************************
    
    NSString *insQL = [NSString stringWithFormat:
                           @"select num from CustomerCard where code= \"%@\" ",searchField];
    
    const char *stmt = [insQL UTF8String];
    
    if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK) {
        
        while(sqlite3_step(statement_1) == SQLITE_ROW) {
            count= (int )sqlite3_column_int(statement_1, 0);
        }
    }
    
    sqlite3_finalize(statement_1);
 
    //***************************   END  TEST    ***************************************

    NSString *countString=nil;
   
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
        [self resetRecordInTableNamed:tableName
                      withSearchField:searchField];
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


//function to insert rows of customer data into this table
-(void) totUpRecordInTableNamed: (NSString *) tableName
                withSearchField: (NSString *) searchField
{
    sqlite3_stmt *statement;
    NSString *insertSQL = [NSString stringWithFormat:
                           @"UPDATE \"%@\" SET num=num+1 WHERE code =  \"%@\" " ,tableName,
                           searchField];
    
    const char *insert_stmt = [insertSQL UTF8String];
    
    if(sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL) == SQLITE_OK){
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Contact UPDATED");
        } else {
            NSLog(@"Failed to UPDATE contact");
        }
        
    }
    
    else
        NSLog(@"Error when processing update sql staement");
    
    sqlite3_finalize(statement);
}


//function to insert rows of customer data into this table
-(void) resetRecordInTableNamed: (NSString *) tableName
                withSearchField: (NSString *) searchField
{
    sqlite3_stmt *statement;
    NSString *insertSQL = [NSString stringWithFormat:
                           @"UPDATE \"%@\" SET num=0 WHERE code =  \"%@\"" ,tableName,
                           searchField];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
    
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"Contact UPDATED");
    } else {
        NSLog(@"Failed to UPDATE contact");
    }
    
    
    sqlite3_finalize(statement);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
