//
//  ViewController.h
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController
{
    IBOutlet UIButton *course_1;
    IBOutlet UILabel *lable_text;

    int count;    
    IBOutlet UITextField *userCode;
}
@end
