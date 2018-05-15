//
//  FirstViewController.m
//  occultation
//
//  Created by Norbert Schmidt on 12-09-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//

#import "FirstViewController.h"
#import <Parse/Parse.h>

#import <AudioToolbox/AudioToolbox.h>

#include <sys/types.h>
#include <sys/sysctl.h>

@interface FirstViewController ()

@end


@implementation FirstViewController

@synthesize txtEmail, btnAppearDisappear, btnSubmit, lblAppeared, lblDissappeared, lblLat, lblLong,  lblStatus, lblHeight, lblButtonstatus, lblGPSTime, lblSysTime, btnMiss, lblAppeared_utc,lblDissappeared_utc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Capture", @"Capture");
        self.tabBarItem.image = [UIImage imageNamed:@"78-stopwatch"];
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

}

-(void) viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [lblButtonstatus setFont:[UIFont boldSystemFontOfSize:18]];


    lblButtonstatus.text=@"Always watch the star\nTap when star disappears\nTap when star reappears";

    btnSubmit.enabled=FALSE; btnSubmit.alpha=0.3;



    locmanager = [[CLLocationManager alloc] init];
    [locmanager setDelegate:self];
    [locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locmanager startUpdatingLocation];
    

    teller=0;        lblButtonstatus.hidden=FALSE;

    txtEmail.hidden=TRUE;
	// Do any additional setup after loading the view, typically from a nib.

    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        
        double dblLat=        geoPoint.latitude;
        double dblLong=        geoPoint.longitude;

        
        lblLat.text=[NSString stringWithFormat:@"%.4f", dblLat];
        lblLong.text=[NSString stringWithFormat:@"%.4f", dblLong];

    
}
     ];
    
}


- (IBAction)buttonClicked:(id)sender {
    
    lblAppeared.hidden=FALSE;
    lblDissappeared.hidden=FALSE;
    btnMiss.hidden=TRUE;
// store location and time
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

     NSString *strDatetime;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        strDatetime = [dateFormatter stringFromDate:now];
    
    
    
    lblSysTime.text=strDatetime;
    
    
    
    


    NSString *strDatetime_utc;
    NSDate *now_utc = [NSDate date];

    NSDate *localDate = now_utc;
        NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:localDate];
    NSDate *gmtDate = [localDate dateByAddingTimeInterval:-timeZoneOffset];

    strDatetime_utc = [dateFormatter stringFromDate:gmtDate];
    NSLog(@"Date UTC %@", strDatetime_utc);
    
    lblButtonstatus.text=@"";

    //
    
        if (teller==0)    {
         
         lblAppeared.text=@"";
         lblDissappeared.text=strDatetime;
            lblDissappeared_utc.text=strDatetime_utc;
            btnSubmit.enabled=FALSE;btnSubmit.alpha=0.3;
            sleep(0.3);
        
            lblButtonstatus.text=@"Tap when star reappears" ;
         

             }
        
 
        if (teller==1)    {    lblAppeared.text=strDatetime;
            lblAppeared_utc.text=strDatetime_utc;
            btnSubmit.enabled=TRUE;
            btnMiss.hidden=TRUE;
            btnSubmit.alpha=1.0;
        
             }
            
            
        
        
        
        
      

    
    teller++;

    if (teller>1)
    
    {
    
    
    
        
        lblButtonstatus.text=@"Please click 'Report D&R button' below\n to report your D & R times";
        btnAppearDisappear.enabled=FALSE;
        txtEmail.hidden=FALSE;
        btnSubmit.enabled=TRUE;
        
         teller=0;
        
        
    }

    
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    lblHeight.text = [NSString stringWithFormat: @"%.2f m",   newLocation.altitude];
    NSDate *now= newLocation.timestamp;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
	NSString *strDatetime = [dateFormatter stringFromDate:now];
    
    lblGPSTime.text=strDatetime;
    NSString *strDatetime2;
    NSDate *now2 = [NSDate date];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    [dateFormatter2 setTimeZone:gmt];
    
    strDatetime2 = [dateFormatter2 stringFromDate:now2];
    
    lblSysTime.text=strDatetime2;
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    lblHeight.text = @"0.00 m";
}







-(IBAction) SubmitDataMiss {
    
    
    lblButtonstatus.text=@"Always watch the star\nTap when star disappears\nTap when star reappears";
    btnAppearDisappear.enabled=FALSE;
    lblButtonstatus.hidden=TRUE;
    txtEmail.hidden=FALSE;
    btnSubmit.hidden=FALSE;
    teller=0;
    
    
    
    
    
    [Parse setApplicationId:@"0cnw89JsPaLAYpv8eiBPVwL100QdIKEcFK6tkCSF"
                  clientKey:@"AZGgWC4LfjdZhtFjHCYtCULah9klz2eXg8w7F0XW"];
    
    
    // Device
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    // Date/time
    NSString *strDatetime;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	strDatetime = [dateFormatter stringFromDate:now];
    
    // DeviceID
    
    
    
    
    NSString *deviceUDID =            [[[UIDevice currentDevice] identifierForVendor] UUIDString];

    
    
    
    // Store data in a parse.com object.
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        
        
        NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
        
        NSString *dissappeared =@"Miss";
        
        NSString *appeared=@"Miss";
        NSString *height=[NSString stringWithFormat:@"%@",[lblHeight text]];
        
        
        NSString *user_name = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_name"];
        NSString *user_surname = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_surname"];
        
        NSString *user_email = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_email"];
        
        PFObject *SQMMeasurement = [PFObject objectWithClassName:@"occdata"];
        [SQMMeasurement setObject:deviceUDID forKey:@"device_id"];
        [SQMMeasurement setObject:strDatetime forKey:@"datetimesubmitted_utc"];
        [SQMMeasurement setObject:user_name forKey:@"user_name"];
        [SQMMeasurement setObject:user_surname forKey:@"user_surname"];
        [SQMMeasurement setObject:user_email forKey:@"user_email"];
        
        [SQMMeasurement setObject:height forKey:@"height"];
        [SQMMeasurement setObject:geoPoint forKey:@"location"];
        [SQMMeasurement setObject:[NSNumber numberWithDouble: geoPoint.latitude     ]  forKey:@"lat"];
        [SQMMeasurement setObject:[NSNumber numberWithDouble: geoPoint.longitude ] forKey:@"lon"];
        
        
        [SQMMeasurement setObject:dissappeared forKey:@"disappeared_utc"];
        [SQMMeasurement setObject:appeared forKey:@"appeared_utc"];
        
        [SQMMeasurement setObject:platform forKey:@"platform"];
        [SQMMeasurement setObject:version forKey:@"swversion"];
        [SQMMeasurement saveEventually];
        
        SQMMeasurement=NULL;
    }
     ];
    
    
    
// here popup!    [btnAppearDisappear setTitle:@"Miss reported" forState:UIControlStateNormal];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Occultation"
                                                    message:@"A miss for your location has been reported."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
        teller=0;
        
    btnSubmit.enabled=FALSE;
    btnSubmit.alpha=0.3;
    lblButtonstatus.hidden=FALSE;
    btnAppearDisappear.enabled=TRUE;
    [btnAppearDisappear setTitle:@"Tap when star disappears" forState:UIControlStateNormal];
    
    lblStatus.text=@"Results submitted, thanks!";
    lblStatus.text=@"Tap when star disappears";
    
    btnMiss.hidden=FALSE;
    
    lblAppeared.hidden=TRUE;
    lblDissappeared.hidden=TRUE;
    
    

    
    
    
    
}





-(IBAction) SubmitData {
    
    [Parse setApplicationId:@"0cnw89JsPaLAYpv8eiBPVwL100QdIKEcFK6tkCSF"
                  clientKey:@"AZGgWC4LfjdZhtFjHCYtCULah9klz2eXg8w7F0XW"];
    
    
    // Device
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    // Date/time
    NSString *strDatetime;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	strDatetime = [dateFormatter stringFromDate:now];
    
    // DeviceID
  	NSString *deviceUDID =            [[[UIDevice currentDevice] identifierForVendor] UUIDString];

    
    
    
    
    
    
    // Store data in a parse.com object.
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        
        
        NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    
        NSString *dissappeared =[NSString stringWithFormat:@"%@",[lblDissappeared text]];
        NSString *appeared=[NSString stringWithFormat:@"%@",[lblAppeared text]];
        NSString *dissappeared_utc =[NSString stringWithFormat:@"%@",[lblDissappeared_utc text]];
        NSString *appeared_utc=[NSString stringWithFormat:@"%@",[lblAppeared_utc text]];

        NSString *height=[NSString stringWithFormat:@"%@",[lblHeight text]];

        
        NSLog(@"Eerste %@ Tweede %@", dissappeared, appeared);
        NSString *user_name = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_name"];
        NSString *user_surname = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_surname"];
        
        NSString *user_email = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_email"];
        
        PFObject *SQMMeasurement = [PFObject objectWithClassName:@"occdata"];
        [SQMMeasurement setObject:deviceUDID forKey:@"device_id"];
        [SQMMeasurement setObject:strDatetime forKey:@"datetimesubmitted"];
        [SQMMeasurement setObject:user_name forKey:@"user_name"];
        [SQMMeasurement setObject:user_surname forKey:@"user_surname"];
        [SQMMeasurement setObject:user_email forKey:@"user_email"];

        [SQMMeasurement setObject:height forKey:@"height"];
        [SQMMeasurement setObject:geoPoint forKey:@"location"];
        [SQMMeasurement setObject:[NSNumber numberWithDouble: geoPoint.latitude     ]  forKey:@"lat"];
        [SQMMeasurement setObject:[NSNumber numberWithDouble: geoPoint.longitude ] forKey:@"lon"];
    
        [SQMMeasurement setObject:dissappeared forKey:@"disappeared"];
        [SQMMeasurement setObject:appeared forKey:@"appeared"];
        
        [SQMMeasurement setObject:dissappeared_utc forKey:@"disappeared_utc"];
        [SQMMeasurement setObject:appeared_utc forKey:@"appeared_utc"];

        [SQMMeasurement setObject:platform forKey:@"platform"];
        [SQMMeasurement setObject:version forKey:@"swversion"];
        [SQMMeasurement saveEventually];
        
        SQMMeasurement=NULL;
    }
     ];
    
 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Occultation"
                                                    message:@"Your data was sent to our servers.\nThank you!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
        lblButtonstatus.text=@"";
    
  //  txtEmail.hidden=TRUE;
    btnSubmit.enabled=FALSE;
    btnSubmit.alpha=0.3;
    lblButtonstatus.hidden=FALSE;
    btnAppearDisappear.enabled=TRUE;
    
    btnMiss.hidden=FALSE;
    lblButtonstatus.text=@"Always watch the star\nTap when star disappears\nTap when star reappears";

    lblAppeared.hidden=TRUE;
    lblDissappeared.hidden=TRUE;
    
}
-(IBAction)infobtn_click:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Occultation help"
                                                    message:@"Occultation uses Location Services to determine where you were standing when you made your observation.\nIt is very important to know where each observer was located since that determines what part of the asteroid they are measuring.\nUse Occultation as follows:  First be safe.  Only observe from safe locations.  While always keeping your eye on the target star (either by looking directly at it or, if it is dim, by viewing it in binoculars or a telescope), tap the large red button when you see the star disappear, and again when you see it reappear.  The phone will shake to confirm that each of your taps was received, so you do not have to look away from the star.  Once you have recorded the times of disappearance and reappearance, tap the Submit your D&R Times' button to send your times and current GPS location to IOTA’s servers.\nIf you do not see the star disappear within a minute or so on either side of the predicted time, then tap on the “Report a Miss” button.  In this case your location along with the indication that the star did not disappear will be sent to IOTA’s servers.\n\nNote:  Yes, we know the Sun is a star but remember:  never look directly at the Sun, and especially never look at it through binoculars or a telescope!  Occultation is designed for use at night only, not for Solar eclipses or any event having to do with the Sun!\nPlease provide your email address and name during installation in case IOTA’s analysts have questions about your observation.  Since your data will be contributing to the science of asteroid measurement it may be necessary to contact you if there are questions about your observed times or location.  No other use of your information will be made."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
