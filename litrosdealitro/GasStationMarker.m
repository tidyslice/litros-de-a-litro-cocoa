//
//  GasStationMarker.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 04/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GasStationMarker.h"

@implementation GasStationMarker

@synthesize name;
@synthesize address;
@synthesize coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate
{
  self = [super init];
  if (self) {
    coordinate = theCoordinate;
  }
  return self;
}

- (void)dealloc
{
  [name release];
  [address release];
  [super dealloc];
}

- (NSString *)title 
{
  return self.name;
}

- (NSString *)subtitle 
{
  return self.address;
}



@end
