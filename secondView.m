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
    
    sqlite3_stmt *statement;
    
    
    NSString *insertSQL = [NSString stringWithFormat:
                           @"UPDATE \"%@\" SET num=num+1 WHERE code =  \"%@\" " ,self->tableName,
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
    
    
    
    [alertMsg show];
}



/*
 //function to insert rows of customer data into this table
 -(void) totUpRecordInTableNamed: (NSString *) tableName
 withSearchField: (NSString *) searchField
 andTotUpField: (int) totUpField
 {
 
 
 //NSString *sqlStr = [NSString stringWithFormat: @"INSERT OR REPLACE INTO '%@' ('%@', '%@','%d') VALUES (?,?,?)",
 //                    tableName, field1, field2, field3];
 
 //NSString *sqlStr = [NSString stringWithFormat:  @"UPDATE '%@' SET 0 ='@'+1 WHERE '@' = ?  ", tableName,totUpField,searchField];
 
 const char *sql = [sqlStr UTF8String];
 sqlite3_stmt *statement;
 
 if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
 sqlite3_bind_text(statement, 1, [searchField UTF8String], -1, NULL);
 sqlite3_bind_int(statement, 2, totUpField);
 // not sure  could be error here  - syntax guessed !
 }
 
 if (sqlite3_step(statement) != SQLITE_DONE)
 NSAssert(0, @" what !! - Error updating table. --  error no. = %d " ,sqlite3_step(statement));
 
 
 sqlite3_finalize(statement);
 
 }
 */



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
