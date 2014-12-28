//
//  secondView.h
//  GoldenScissors
//
//  Created by EventHorizon on 21/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface secondView : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIButton *totUp_button;
    IBOutlet UITextField *codeBox;
    IBOutlet UILabel *totUp_label;
    
    int count;
    NSString *tableName;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
