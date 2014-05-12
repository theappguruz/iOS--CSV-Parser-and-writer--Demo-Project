//
//  ViewController.h
//  SampleProject
//
//  Created by TheAppGuruz-New-6 on 06/05/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCSVParser.h"
@interface ViewController : UIViewController<CHCSVParserDelegate>

- (IBAction)btnWrite:(id)sender;
- (IBAction)btnDismissKeyboardClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtRno;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtMarks;



@end
