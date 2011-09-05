//
//  GasolineraController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"

@interface GasolineraController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
  MKMapView *mapa;    
  UIView* infoView;
  UIView* mapaView;    
  NSString *stationId;
  UITableView *tableView;
  
  ASIHTTPRequest *request;
  NSDictionary *gasStation;
  
}

@property(nonatomic, retain) NSString *stationId;
@property(nonatomic, retain) ASIHTTPRequest *request;
@property(nonatomic, retain) NSDictionary *gasStation;
@property(nonatomic, retain) IBOutlet MKMapView *mapa;
@property(nonatomic, retain) IBOutlet UIView *infoView;
@property(nonatomic, retain) IBOutlet UIView *mapaView;
@property(nonatomic, retain) IBOutlet UITableView *tableView;

- (id)initWithGasStation:(NSString *)theId;
- (IBAction)togglePanels:(id)sender;


@end
