//
//  searchNameView.h
//  GoldenScissors
//
//  Created by EventHorizon on 03/01/2015.
//  Copyright (c) 2015 EventHorizon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface searchNameView : UIViewController
{
    IBOutlet UIButton *removeButton;
    IBOutlet UITextField *removeBox;
    IBOutlet UILabel *remove_label;
    
    int count;
    NSString *tableName;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
