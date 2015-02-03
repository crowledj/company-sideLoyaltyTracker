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
   
    //reset btn_press counter
    //btn_counter=0;
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    //contentView.backgroundColor = [UIColor whiteColor];

    self.view = contentView;
    self.title = @"Search Customer by name";
    //[self setTitle:@"Search Customer by name"];
    
    //define class postiiton variables.
    leftLabel_x=20,leftLabel_y=250,leftLabel_width=125,leftLabel_height=35;
    midLabel_x=120,midLabel_y=250,midLabel_width=125,midLabel_height=35;
    rightLabel_x=240,rightLabel_y=250,rightLabel_width=125,rightLabel_height=35;
    incremt=25;
    
    int textFeild_x=100,textFeild_y=125,textFeild_width=150,textFeild_height=incremt;
    int button_x=textFeild_x,button_y=textFeild_y+75,button_width=textFeild_width,button_height=textFeild_height+incremt;
    
    //add page label
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor=[UIColor yellowColor];
    label.text = @"Search Database by Customer Name :";
    [self.view addSubview:label];
   
    //add labels for results :
    UILabel  *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel_x, leftLabel_y, leftLabel_width, leftLabel_height)];
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    codeLabel.textColor=[UIColor yellowColor];
    codeLabel.text = @"Unique Code :";
    [codeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:codeLabel];
    
    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(midLabel_x, midLabel_y, midLabel_width, midLabel_height)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor=[UIColor yellowColor];
    nameLabel.text = @"Customer Name :";
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:nameLabel];
    
    
    UILabel  *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightLabel_x,rightLabel_y,rightLabel_width, rightLabel_height)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textAlignment = NSTextAlignmentLeft;
    countLabel.textColor=[UIColor yellowColor];
    countLabel.text = @"Haircut no.:";
    [countLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:countLabel];
    
    /**** test parameters  ***/
    
    searchbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchbutton addTarget:self
                     action:@selector(namePressed:)
           forControlEvents:UIControlEventTouchUpInside];
    [searchbutton setTitle:@"Display Result(s) !" forState:UIControlStateNormal];
    searchbutton.frame = CGRectMake(button_x, button_y, button_width, button_height);
    searchbutton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Yellow_Option-Button_small.png"]];
    [self.view addSubview:searchbutton];

    tf = [[UITextField alloc] initWithFrame:CGRectMake(textFeild_x ,textFeild_y, textFeild_width, textFeild_height)];
    tf.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    tf.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    tf.backgroundColor=[UIColor whiteColor];
    [tf.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [tf.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    tf.layer.cornerRadius = 5;
    tf.clipsToBounds = YES;
    tf.text=@"";
    
    self->tf.delegate = self;
    [self.view addSubview:tf];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Fiber-Carbon-Tiled-Pattern-background-vol.11.jpg"]];
    
    //open/create database
    int result = sqlite3_open([[self filePath] UTF8String],&db);
    
    if(result != SQLITE_OK)
        NSLog(@"Error : database not opened or created in %@ ",[self filePath]);
    
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)namePressed:(UIButton *)sender
{
    NSString *searchField = tf.text;
    UIAlertView *alertMsg=nil;
    sqlite3_stmt *statement_1;
    //DBError *errorMsg=nil;
    
    //***************************     TEST    **************************************
    
    NSString *insQL = [NSString stringWithFormat:
                       @"select * from CustomerCard where customerName = \"%@\" ",searchField];
    
    const char *stmt = [insQL UTF8String];
    int row_counter=0;//counter to handle duplicate customer names
    
    
    //UILabel  * label_3;
    
    if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK) {
        
        //DECLARE STRING TO STORE USERS NAME (NEEDED HERE FOR ERROR POP-UP MSG)
        NSString *dbMessageText=nil;
        
        while (1){
            
            int rc = sqlite3_step(statement_1);
            
            NSLog(@"about to go into while(1) -- rc = %d",rc);
            
            if(rc == SQLITE_ROW){
                
                NSLog(@"at v. start of sql while loop IN SUCCESSFUL SQL_LITE_ROW");
                
                row_counter++;
                
                NSString *dbMessageID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 0)];
                dbMessageText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 1)];
                int dbMessageDate = (int )sqlite3_column_int(statement_1, 2);
                
                NSLog(@"in while sql loop -- dbMessageID = %@ -- dbMessageText = %@ --  dbMessageDate = %d",dbMessageID,dbMessageText,dbMessageDate);
                
                NSString *dbCounterText = [self intToString:dbMessageDate];
                
                UILabel  * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel_x,leftLabel_y+(row_counter*incremt),leftLabel_width,leftLabel_height)];
                label_1.backgroundColor = [UIColor clearColor];
                label_1.textAlignment = NSTextAlignmentLeft;
                label_1.textColor=[UIColor redColor];
                label_1.text = dbMessageID;
                [self.view addSubview:label_1];
                
                UILabel  * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(midLabel_x,midLabel_y+(row_counter*incremt),midLabel_width,midLabel_height)];
                label_2.backgroundColor = [UIColor clearColor];
                label_2.textAlignment = NSTextAlignmentLeft;
                label_2.textColor=[UIColor redColor];
                label_2.text = dbMessageText;
                [self.view addSubview:label_2];
                
                UILabel  * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(rightLabel_x,rightLabel_y+(row_counter*incremt),rightLabel_width, rightLabel_height)];
                label_3.backgroundColor = [UIColor clearColor];
                label_3.textAlignment = NSTextAlignmentLeft;
                label_3.textColor=[UIColor redColor];
                label_3.text = dbCounterText;
                [self.view addSubview:label_3];
            }
            
            //handle case where no rows return
            else if (rc != SQLITE_ROW && row_counter == 0)
            {
                NSLog(@"SQL _step statement finished returning no rows");
                [self alert:alertMsg PopupWith:/*dbMessageText*/searchField];
                break;
            }
            
            //default case : finished executing all rows for a successful reult.
            else
            {
                NSLog(@"SQL _step statement finished returning > 0 rows");
                break;
            }
            
        }//end infinite while
        
    }//end if checking for rows
    
    else
    {
        //reset row counter
        row_counter=0;
        NSLog(@"Error in prcessing sql query -- errmsg = ->%s<-",sqlite3_errmsg(db));
    }
    
    //[label_3 removeFromSuperview];
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
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:16.0];
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        titleView.textColor = [UIColor yellowColor]; // Change to desired color
        
        self.navigationItem.titleView = titleView;
        //[titleView release];
    }
    titleView.text = title;
    [titleView sizeToFit];
}
*/

-(void) alert:(UIAlertView *) alert PopupWith: (NSString *) name
{
    NSLog(@"in alert method  !");
    
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

@end
