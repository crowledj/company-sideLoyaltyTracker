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

    
    //open/create database
    //int result = sqlite3_open([[self filePath] UTF8String],&db);
    
    //if(result != SQLITE_OK)
       //NSLog(@"Error : database not opened or created in %@ ",[self filePath]);
    
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
    sqlite3_stmt *statement_1;
    char *zErrMsg = 0;
    NSString *insQL = [NSString stringWithFormat:
                       @"DELETE FROM CustomerCard where code=?"];
    const char *stmt = [insQL UTF8String];
    
    //open/create database
    if((sqlite3_open([[self filePath] UTF8String],&db) == SQLITE_OK))
    {
        if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(statement_1, 1, [removeField UTF8String], -1, SQLITE_TRANSIENT);
        
            if(SQLITE_DONE == sqlite3_step(statement_1))
            {
                NSLog(@"OK while Deleting");
            }
        
            else
            {
                NSLog(@"Failed to delete row in outer step loop -- errmsg = ->%s<-", sqlite3_errmsg(db));
            }
        }
        else
            NSLog(@"Failed to delete row in outer prepare loop -- errmsg = ->%s<-", sqlite3_errmsg(db));
    }
    
    else
           NSLog(@"Error openeing database !");
    sqlite3_finalize(statement_1);
    
    /*   TEST   */
    
    /*
    NSLog(@"*********** LETS have a lookk at full table after DELETE attempt ! ***********  : ");
    
    NSString *insQL_1 = [NSString stringWithFormat:
                       @"select * from CustomerCard "];
    
    NSLog(@" got past '[NSString stringWithFormat:select * from CustomerCard '");
    
    sqlite3_stmt *statement_2;
    const char *stmt1 = [insQL_1 UTF8String];
    
    NSLog(@" got past [insQL_1 UTF8String]");
    
    
    int error_counter=0;
    
    if(sqlite3_prepare_v2(db, stmt1, -1, &statement_2, NULL) == SQLITE_OK) {
        
        while(sqlite3_step(statement_2) == SQLITE_ROW) {
            
            NSLog(@"in while sql statement -- error_counter = %d",error_counter);
            error_counter++;
            
            NSString *dbcodeID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 0)];
            NSString *dbNameText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 1)];
            
            int count= (int )sqlite3_column_int(statement_1, 2);
            const char *codeString = [dbcodeID UTF8String];
            const char *nameString = [dbNameText UTF8String];
            
            NSLog(@"in extract BD method : codeString = %s -- nameString= %s",codeString,nameString);
        
        }
    }
    
    else
            NSLog(@"something FUCKED UP here :( ");
    
    NSLog(@"*********** RIGHT DONE WITH THAT TEST ! ***********  : ");
   
    sqlite3_finalize(statement_2);
     
    */
    
    /*  END TEST   */
          
          
    sqlite3_close(db);
    
    //***************************   END  TEST    ***************************************
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

/*
 //delete record with code entered by user.
 if(sqlite3_exec(db, stmt, NULL, NULL,&zErrMsg) == SQLITE_OK) {
 
 NSLog(@"processing select statement correctly  :)-- SQL string = %@ ",insQL);
 }
 */