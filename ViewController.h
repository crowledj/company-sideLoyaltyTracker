//
//  ViewController.h
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController  <UITextFieldDelegate>
{
    //IBOutlet UILabel *Title;
    
    
    IBOutlet UIButton *course_1;
    IBOutlet UILabel *lable_text;
    IBOutlet UITextField *codeField;
    IBOutlet UILabel *userName;
    IBOutlet UITextField *nameInput;
    
    
    
     int count;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
