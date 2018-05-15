//
//  SecondViewController.m
//  occultation
//
//  Created by Norbert Schmidt on 12-09-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//

#import "SecondViewController.h"



@interface SecondViewController ()


@end



@implementation SecondViewController
@synthesize txtEmail,txtEmailrep,txtFirst,txtLast, btnOK;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"User", @"User");
        self.tabBarItem.image = [UIImage imageNamed:@"111-user"];
    }
    return self;
}


- (void) viewDidAppear:(BOOL)animated {
    
    // hier het resultaat ophalen
    
    
    txtFirst.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
    txtLast.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_surname"];
    txtEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
    
    //   NSLog (@"Achternaam = %@ ", [[NSUserDefaults standardUserDefaults] objectForKey:@"user_surname"]);
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)storeDefaults:(id)sender {
    
    
    // naam wegschrijven
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *valueToSave = txtFirst.text;
    NSString *valueToSave2 = txtLast.text;
    NSString *valueToSave3 = txtEmail.text;
    [standardUserDefaults setObject:valueToSave forKey:@"user_name"];
    [standardUserDefaults setObject:valueToSave2 forKey:@"user_surname"];
    [standardUserDefaults setObject:valueToSave3 forKey:@"user_email"];

    
    [standardUserDefaults synchronize];
    [txtEmail resignFirstResponder];
    [txtEmailrep resignFirstResponder];

    [txtFirst resignFirstResponder];
    [txtLast resignFirstResponder];
            [self.tabBarController setSelectedIndex:0];
}

- (IBAction)hideKeyboard :(id)sender {
       [txtEmail resignFirstResponder];
    [txtEmailrep resignFirstResponder];

    [txtFirst resignFirstResponder];
    [txtLast resignFirstResponder];

    
    
}

@end
