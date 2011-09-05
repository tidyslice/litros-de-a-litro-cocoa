//
//  GasStationMarker.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 04/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GasStationMarker : NSObject<MKAnnotation>
{
  NSString *name;
  NSString *address;
  CLLocationCoordinate2D coordinate;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate;

@end
