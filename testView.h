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
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
