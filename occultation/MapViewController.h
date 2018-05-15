//
//  MapViewController.h
//  Dark Sky Meter
//
//  Created by Norbert Schmidt on 19-02-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
{

    
    IBOutlet MKMapView *ObserverMapView;
    MKPlacemark *mPlacemark;
    IBOutlet UIButton *btnReset;



}

@property (retain, nonatomic) IBOutlet MKMapView *ObserverMapView;
@property (retain, nonatomic) IBOutlet UIButton *btnReset;



- (void) initMap;
- (IBAction)doReset:(id)sender;
@end
