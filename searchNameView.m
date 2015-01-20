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
    
    sqlite3_stmt *statement_1;
    char *zErrMsg = 0;
    
    
    NSString *insQL = [NSString stringWithFormat:
                       @"DELETE FROM CustomerCard where code = \"%@\"",removeField];
    
    
    const char *stmt = [insQL UTF8String];
    
    
    if(sqlite3_exec(db, stmt, NULL, NULL,&zErrMsg) == SQLITE_OK) {
        
         NSLog(@"processing select statement correctly  :)-- SQL string = %@ ",insQL);
    }
    
    sqlite3_finalize(statement_1);
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
