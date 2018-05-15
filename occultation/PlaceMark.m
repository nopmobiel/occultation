//
//  NSObject+PlaceMark.m
//  TOV2012
//
//  Created by Norbert Schmidt on 12-12-11.
//  Copyright (c) 2011 DDQ. All rights reserved.
//
#import "PlaceMark.h"

@implementation PlaceMark
@synthesize coordinate, titletext, subtitletext;

- (NSString *)subtitle{
	return subtitletext;
}
- (NSString *)title{
	return titletext;
}

-(void)setTitle:(NSString*)strTitle {
	self.titletext = strTitle;
}

-(void)setSubTitle:(NSString*)strSubTitle {
	self.subtitletext = strSubTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}
@end
