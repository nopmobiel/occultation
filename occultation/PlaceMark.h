//
//  NSObject+PlaceMark.h
//  TOV2012
//
//  Created by Norbert Schmidt on 12-12-11.
//  Copyright (c) 2011 DDQ. All rights reserved.
//

#import <Foundation/Foundation.h>  
#import <MapKit/MapKit.h>  

@interface PlaceMark : NSObject<MKAnnotation> {  
    CLLocationCoordinate2D coordinate;  
    NSString *subtitletext;  
    NSString *titletext;  
}  
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;  
@property (readwrite, retain) NSString *titletext;  
@property (readwrite, retain) NSString *subtitletext;  
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;  
- (NSString *)subtitle;  
- (NSString *)title;  
-(void)setTitle:(NSString*)strTitle;  
-(void)setSubTitle:(NSString*)strSubTitle;  

@end  