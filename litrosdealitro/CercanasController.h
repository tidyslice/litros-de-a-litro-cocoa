//
//  CercanasController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import <CoreLocation/CoreLocation.h>

@interface CercanasController : UITableViewController<CLLocationManagerDelegate>
{
  NSArray *gasolineras;
  CLLocationManager *locationManager;
}

@property(nonatomic, retain) NSArray *gasolineras;
@property(nonatomic, retain) ASIHTTPRequest *request;

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
