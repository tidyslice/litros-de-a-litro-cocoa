//
//  GasolineraController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GasolineraController.h"

#import "JSON.h"
#import "Constants.h"

@interface GasolineraController ()

- (void)loadGasStation;
- (void)loadGasStationStub;
- (void)updateGasStation:(NSString *)jsonStation;

@end

@implementation GasolineraController

@synthesize request;
@synthesize gasFoto;
@synthesize infoView;
@synthesize mapaView;
@synthesize stationId;
@synthesize gasStation;

- (id)initWithGasStation:(NSString *)theId 
{
  self = [super initWithNibName:@"GasolineraController" bundle:nil];
  if (self) {
    self.stationId = theId;
  }
  return self;
}

- (void)dealloc
{
  [request clearDelegatesAndCancel];
  [request release];
  [gasFoto release];
  [infoView release];
  [mapaView release];  
  [stationId release];
  [gasStation release];
  [super dealloc];
}



#pragma mark -
#pragma mark Actions

-(IBAction)togglePanels:(id)sender {
    UISegmentedControl *toggleControl = (UISegmentedControl *) sender;

    infoView.hidden = toggleControl.selectedSegmentIndex != 0;
    mapaView.hidden = toggleControl.selectedSegmentIndex == 0;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadGasStation];

  UISegmentedControl *toggleViewControl = [[UISegmentedControl alloc] 
                                           initWithItems:[NSArray arrayWithObjects: @"Info", @"Mapa", nil]];
  [toggleViewControl addTarget:self action:@selector(togglePanels:) forControlEvents:UIControlEventValueChanged];
  toggleViewControl.selectedSegmentIndex  = 0;
  toggleViewControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
  UIBarButtonItem *toggleViewBarItem = [[UIBarButtonItem alloc] initWithCustomView:toggleViewControl];
  self.navigationItem.rightBarButtonItem = toggleViewBarItem;
  [toggleViewControl release];
  [toggleViewBarItem release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
}

#pragma mark private methods
- (void)loadGasStation 
{
  
  NSString *urlRequest = [NSString stringWithFormat:STATION_SERVICE_URL, self.stationId];
  NSLog(@"urlRequest %@", urlRequest);
  request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlRequest]];
  [request setDelegate:self];
  [request startSynchronous]; 

}

- (void)loadGasStationStub 
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"station" ofType:@"json"];
  
  [self updateGasStation:[NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil]];
}

- (void)updateGasStation:(NSString *)jsonStation
{
  self.gasStation = [jsonStation JSONValue];
  NSLog(@"jsonstation %@", jsonStation);                    
}

#pragma mark ASIHTTPRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
  
  [self updateGasStation:[theRequest responseString]];
  
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
  NSError *error = [theRequest error];
  NSLog(@"Error %@", error);
}


@end
