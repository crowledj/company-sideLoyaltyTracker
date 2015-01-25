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
    
    self.title = @"Remove Customer with Code";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Fiber-Carbon-Tiled-Pattern-background-vol.11.jpg"]];
}


-(NSString *) filePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDir = [paths lastObject];
    
    
    return[documentsDir stringByAppendingPathComponent:@"NewLoyaltyCard.sql"];
}


-(IBAction)namePressed:(UIButton *)sender
{
    NSString *removeField = removeBox.text;
    UIAlertView *alertMsg=nil;
    sqlite3_stmt *statement_1;
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
           NSLog(@"Error openeing database  -- errmsg = ->%s<-", sqlite3_errmsg(db));
    
    [self alert:alertMsg PopupWith:removeField];
    
    //finalize sql stmt and close DB.
    sqlite3_finalize(statement_1);
    sqlite3_close(db);
}


-(void) alert:(UIAlertView *) alert PopupWith: (NSString *) counter
{
    
    NSString *extraStuff_2 = @"\n";
    NSString *extraStuff_3=nil;
    extraStuff_3 = [extraStuff_2 stringByAppendingString:counter];
    
    alert = [[UIAlertView alloc] initWithTitle:@"Customer DELETED from Database -- with card code "
                                           message: counter
                                          delegate:nil cancelButtonTitle:@"OK I get it ! :)"
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
