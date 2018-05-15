//
//  SecondViewController.h
//  occultation
//
//  Created by Norbert Schmidt on 12-09-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GradientButton.h"

@interface SecondViewController : UIViewController  {
    
    IBOutlet UITextField    *txtFirst;
    IBOutlet UITextField    *txtLast;
    IBOutlet UITextField    *txtEmail;
    IBOutlet UITextField    *txtEmailrep;

    IBOutlet GradientButton    *btnOK;
    
}

@property (nonatomic, retain) UITextField *txtFirst;
@property (nonatomic, retain) UITextField *txtLast;
@property (nonatomic, retain) UITextField *txtEmail;
@property (nonatomic, retain) UITextField *txtEmailrep;

@property (nonatomic, retain) GradientButton *btnOK;

@end
