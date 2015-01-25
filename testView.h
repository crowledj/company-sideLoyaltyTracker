//
//  testView.h
//  GoldenScissors
//
//  Created by EventHorizon on 04/01/2015.
//  Copyright (c) 2015 EventHorizon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface testView : UIViewController
{
    IBOutlet UIButton *searchbutton;
    IBOutlet UITextField *tf;
    //IBOutlet UILabel *search_label;
    
    //some hardcoded positional stuff here (for labels & results)
    int leftLabel_x,leftLabel_y,leftLabel_width,leftLabel_height;
    int midLabel_x,midLabel_y,midLabel_width,midLabel_height;
    int rightLabel_x,rightLabel_y,rightLabel_width,rightLabel_height;
    int incremt;
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(void)setTitle:(NSString *)title;

@end
