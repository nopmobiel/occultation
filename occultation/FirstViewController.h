//
//  FirstViewController.h
//  occultation
//
//  Created by Norbert Schmidt on 12-09-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <CLLocationManagerDelegate>
{
    IBOutlet UITextField    *txtEmail;
    IBOutlet UILabel    *lblDissappeared;
    IBOutlet UILabel    *lblAppeared;
    IBOutlet UILabel    *lblDissappeared_utc;
    IBOutlet UILabel    *lblAppeared_utc;

    IBOutlet UILabel    *lblLat;
    IBOutlet UILabel    *lblLong;
    IBOutlet UILabel    *lblStatus;
    IBOutlet UILabel    *lblHeight;
    IBOutlet UILabel    *lblGPSTime;
    IBOutlet UILabel    *lblSysTime;

    IBOutlet UITextView    *lblButtonstatus;
    IBOutlet UIButton    *btnMiss;

    IBOutlet UIButton    *btnSubmit;
    IBOutlet UIButton    *btnAppearDisappear;
    int teller;
    CLLocationManager  *locmanager;

}

@property (nonatomic, retain) UITextField *txtEmail;
@property (nonatomic, retain) UIButton *btnSubmit;
@property (nonatomic, retain) UIButton *btnAppearDisappear;
@property (nonatomic, retain) UIButton *btnMiss;
@property (nonatomic, retain) IBOutlet UILabel    *lblDissappeared_utc;
@property (nonatomic, retain) IBOutlet UILabel    *lblAppeared_utc;
@property (nonatomic, retain) IBOutlet UILabel    *lblDissappeared;
@property (nonatomic, retain) IBOutlet UILabel    *lblAppeared;
@property (nonatomic, retain) IBOutlet UITextView    *lblButtonstatus;
@property (nonatomic, retain) IBOutlet UILabel    *lblGPSTime;
@property (nonatomic, retain) IBOutlet UILabel    *lblSysTime;

@property (nonatomic, retain) IBOutlet UILabel    *lblLat;
@property (nonatomic, retain) IBOutlet UILabel    *lblLong;
@property (nonatomic, retain) IBOutlet UILabel    *lblStatus;
@property (nonatomic, retain) IBOutlet UILabel    *lblHeight;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *) oldLocation ;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *) error;


@end
