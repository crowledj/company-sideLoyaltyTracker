//
//  secondView.m
//  GoldenScissors
//
//  Created by EventHorizon on 21/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "secondView.h"

@interface secondView ()
{

}
@end

@implementation secondView

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    card_button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    
    //text_label.font= [UIFont boldSystemFontOfSize:16];    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
