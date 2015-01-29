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
    NSString *removeField = removeBox.text;
    UIAlertView *alertMsg=nil;
    sqlite3_stmt *statement_1 = NULL;
    NSString *insQL = [NSString stringWithFormat:
                       @"DELETE FROM CustomerCard where code=?"];
    const char *stmt = [insQL UTF8String];
    int row_count=0;
    
   // BOOL *checkCodeExists=NO;
    
    if([self checkDBforEntry:removeField])
    {
        if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK)
        {
            int ansBind=sqlite3_bind_text(statement_1, 1, [removeField UTF8String], -1, SQLITE_TRANSIENT);
        
            int resCode=sqlite3_step(statement_1);
            
            NSLog(@"about to go rc WITHOUT bind statement used  and  -- rc = %d -- & bind result = %d",resCode,ansBind);
            
            if( resCode == SQLITE_DONE )
            {
                NSLog(@"OK while Deleting");
                row_count++;
                [self alert:alertMsg PopupWith:removeField];
            }
            
            else if(  resCode!= SQLITE_DONE && row_count == 0 )
            {
                NSLog(@"ERROR while Deleting -- customer code potentially does not exist !! :( ");
                [self errorAlert:alertMsg PopupWith:removeField];
            }
            
            else
            {
                NSLog(@"Failed to delete row in outer step loop -- errmsg = ->%s<- -- but row no. is non -zero! ? ", sqlite3_errmsg(db));
                NSString *errorMsg=@"ERROR - but row no. is non -zero! ?";
                [self errorAlert:alertMsg PopupWith:errorMsg];
            }
            
        }
        else
            NSLog(@"Failed to delete row in outer prepare loop -- errmsg = ->%s<-", sqlite3_errmsg(db));
        
    }
    //}
    
    else
    {
        NSLog(@"ERROR while Deleting -- customer code potentially does not exist !! :( ");
        [self errorAlert:alertMsg PopupWith:removeField];
    }
    
    //else
           //NSLog(@"Error openeing database  -- errmsg = ->%s<-", sqlite3_errmsg(db));
    
    //finalize sql stmt and close DB.
    if([self checkDBforEntry:removeField])
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


-(void) errorAlert:(UIAlertView *) alert PopupWith: (NSString *) name
{
    NSString *extraStuff_2 = @"\n";
    NSString *extraStuff_3=nil;
    
    if(name==nil)
        name = @"-><-";
    extraStuff_3 = [extraStuff_2 stringByAppendingString:name];
    
    alert = [[UIAlertView alloc] initWithTitle:@"User does not exist in database :"
                                       message: extraStuff_3
                                      delegate:nil cancelButtonTitle:@"Please re-try! ( its case sensitive:) )"
                             otherButtonTitles:nil];
    [alert show];
}


-(BOOL) checkDBforEntry: (NSString *) userCode
{
    BOOL success=NO;
    
    sqlite3_stmt *state_1;
    NSString *insQL = [NSString stringWithFormat:
                       @"SELECT * FROM CustomerCard where code=  \"%@\" ",userCode];
    const char *stmt = [insQL UTF8String];
    int row_count=0;
    char *zErrMsg = 0;
    
    NSLog(@" *** CHECK : stmt = %s *** ",stmt);
    
    //open/create database
    if((sqlite3_open([[self filePath] UTF8String],&db) == SQLITE_OK))
    {
        if(sqlite3_prepare_v2(db, stmt, -1, &state_1, NULL) == SQLITE_OK)
        {
        //if(sqlite3_exec(db, stmt, NULL, NULL,&zErrMsg) == SQLITE_OK)
        //{
            //NSLog(@"exectuted SELECT statement successfully --- code = %@!",userCode);
            //int ansBind=sqlite3_bind_text(state_1, 1, [userCode UTF8String], -1, SQLITE_TRANSIENT);
            //if(!ansBind){
            
            while (1){
                
                //int rc = sqlite3_step(statement_1);
                
                //NSLog(@"about to go into while(1) -- rc = %d",rc);
                
                if( sqlite3_step(state_1) == SQLITE_ROW){
                    
                    NSLog(@"*** IN SELECT ALL -- IE ENTRY *HAS* ROWS ! ***");
                    
                    //row_counter++;
                    
                    NSString *dbMessageID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(state_1, 0)];
                    NSString *dbMessageText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(state_1, 1)];
                    
                    NSLog(@"bind returned successfully -- and 'turining on' uccess parameter -- dbMessageText = ->%@<- ",dbMessageText);
                    success=YES;
                }//end sql row - step loop
                
                else{
                    
                    NSLog(@" *** IN ELSE OF STEP IN SELECT ALL -- IE ENTRY HAS NO ROWS ! *** ");
                    break;
                }
                
            }//end while
            
            //}
        }
    }
    
    else
        NSLog(@"Error openeing database  -- errmsg = ->%s<-", sqlite3_errmsg(db));
    
    return success;
}

@end
