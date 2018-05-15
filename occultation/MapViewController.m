//
//  MapViewController.m
//  Dark Sky Meter
//
//  Created by Norbert Schmidt on 19-02-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define MERCATOR_RADIUS 85445659.44705395
#import "MapViewController.h"
#import <Parse/Parse.h>
#import "PlaceMark.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "ZSPinAnnotation.h"

@interface MapViewController ()

@end


@implementation MapViewController


@synthesize btnReset, ObserverMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Map", @"Map");
        self.tabBarItem.image = [UIImage imageNamed:@"07-map-marker"];
    }
    return self;
}




- (void) initMap {
    

    // Store data in a parse.com object.
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };

        // Initieel het centrum van de kaart op de GPS verkregen waarde zetten.
        region.center.latitude = geoPoint.latitude;
        region.center.longitude = geoPoint.longitude;
        // Userlatitude (de maps) vullen met initiele waarden
        
        // Initiele grootte kaart
        region.span.longitudeDelta = 1;
        region.span.latitudeDelta = 1;
        
        
        [ObserverMapView setRegion:region animated:NO];
        [ObserverMapView setDelegate:self];
 
        
    }
     ];







}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPin"] ;
    annView.animatesDrop=NO;
    annView.canShowCallout = YES;
    [annView setSelected:YES];
    

    
    
    
        
        annView.pinColor = MKPinAnnotationColorGreen;
 

        
    
    

    
    
    annView.calloutOffset = CGPointMake(-5, 5);
    
    return annView;
    
    
}

-(float) Mapzoomlevel {
    
    return 21- round(log2(ObserverMapView.region.span.longitudeDelta *
                          MERCATOR_RADIUS * M_PI / (180.0 * ObserverMapView.bounds.size.width)));
    
}
 

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    MKCoordinateRegion mapRegion;
    // set the center of the map region to the now updated map view center
    mapRegion.center = mapView.centerCoordinate;
    
    mapRegion.span.latitudeDelta = 0.3; // you likely don't need these... just kinda hacked this out
    mapRegion.span.longitudeDelta = 0.3;
    
    // get the lat & lng of the map region
    double lat = mapRegion.center.latitude;
    double lng = mapRegion.center.longitude;
    
        
        PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:lat longitude:lng ];

            // Now get info
            PFQuery *query = [PFQuery queryWithClassName:@"occdata"];
            [query whereKey:@"location" nearGeoPoint:point withinKilometers:800.0];
            [query orderByDescending:@"datetimesubmitted"];
         //   query.cachePolicy=kp\;
            query.limit = 100;
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                // Get objects nearby.
                // Pindrop laten zien
                PlaceMark *Annotation;
            //    NSLog (@"Obj count %d", objects.count);
                // Show last x measurements
                CLLocationCoordinate2D Coord;
                
                PFGeoPoint *geopoint;
                
                
                for (int i = 0; i < objects.count; i++) {
             //       NSLog(@"Objects count %d", objects.count);
               
                    NSString *disappeared = [[objects valueForKey:@"disappeared"] objectAtIndex:i] ;
     
                    
                    

                    geopoint=  [[objects valueForKey:@"location"] objectAtIndex:i];
                    
                    
                    Coord= CLLocationCoordinate2DMake(geopoint.latitude, geopoint.longitude);
                    
                    Annotation = [[PlaceMark alloc] initWithCoordinate: Coord] ;
  
                    
                    [Annotation setTitle:@"Disappeared"];
                    [Annotation setSubTitle:disappeared];
                    [ObserverMapView addAnnotation:Annotation];
                }
            }];



            
            
            
            



    
    
}



- (IBAction)doReset:(id)sender {
    // Reset to defaults using initMap
    [self initMap];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	   [ObserverMapView setDelegate:self];
    [ObserverMapView setMapType:MKMapTypeStandard];
    [ObserverMapView setZoomEnabled:YES];
    [ObserverMapView setScrollEnabled:YES];
    
    UIColor *NightColor=[UIColor colorWithRed:70 green:0 blue:0 alpha:0.8];
    
    
    [self navigationController].navigationBar.titleTextAttributes=
    [NSDictionary dictionaryWithObjectsAndKeys:
     NightColor, UITextAttributeTextColor,
     [UIFont fontWithName:@"NexaBold" size:25.0], UITextAttributeFont,nil];
    self.title=@"Occultation Map";
    
    

    
}

- (void)viewWillAppear:(BOOL)animated {
        [self initMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
