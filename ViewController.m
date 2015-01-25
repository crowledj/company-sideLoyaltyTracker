//
//  ViewController.m
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    sqlite3 *db;
}
@end


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self->codeField.delegate = self;
    self->nameInput.delegate = self;
    
    self.view.tintColor = [UIColor redColor];
    self.title = @"Add New Customer";
    [[UINavigationBar appearance] setBackgroundColor:[UIColor yellowColor]];
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
    NSString *nameField = nameInput.text;
    NSString *codeName = codeField.text;
    
    UIAlertView *alertMsg=nil;
    
    [self insertRecordIntoTableNamed: @"CustomerCard" withField1:@"code" field1Value:codeName
                           andField2:@"customerName" field2Value: nameField
                           andField3:@"num" field3Value:0];
    //[alertMsg show];
    [self alert:alertMsg PopupWith:nameField];
}

- (IBAction)didPressLink:(UIButton *)sender {
    NSLog(@"in dropbox linker method !");
    [[DBAccountManager sharedManager] linkFromController:self];
    NSLog(@"executed in dropbox linker method !");
}


//function to insert rows of customer data into this table
-(void) insertRecordIntoTableNamed: (NSString *) tableName
						withField1: (NSString *) field1 field1Value: (NSString *) field1Value
                        andField2:(NSString *) field2  field2Value: (NSString *) field2Value
                        andField3:(NSString *) field3  field3Value: (int) field3Value
{
	
	
	NSString *sqlStr = [NSString stringWithFormat: @"INSERT OR REPLACE INTO '%@' ('%@', '%@','%@') VALUES (?,?,?)",
                        tableName, field1, field2, field3];
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement;
    
	if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
		sqlite3_bind_text(statement, 1, [field1Value UTF8String], -1, NULL);
		sqlite3_bind_text(statement, 2, [field2Value UTF8String], -1, NULL);
        sqlite3_bind_int(statement, 3, field3Value);  // not sure  could be error here  - syntax guessed !
	}
    
	if (sqlite3_step(statement) != SQLITE_DONE)
		NSAssert(0, @" what !! - Error updating table.");
    
	sqlite3_finalize(statement);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) alert:(UIAlertView *) alert PopupWith: (NSString *) name
{
    NSString *extraStuff_2 = @"\n";
    NSString *extraStuff_3=nil;
    extraStuff_3 = [extraStuff_2 stringByAppendingString:name];

    alert = [[UIAlertView alloc] initWithTitle:@"Customer added to database :"
                                           message: extraStuff_3
                                          delegate:nil cancelButtonTitle:@"OK I get it ! :)"
                                 otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
