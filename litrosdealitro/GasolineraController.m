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
#import "EGOImageView.h"
#import "GasStationMarker.h"
#import <QuartzCore/QuartzCore.h>


@interface GasolineraController ()

- (void)loadGasStation;
- (void)loadGasStationStub;
- (void)addGasStationToMap;
- (void)updateGasStation:(NSString *)jsonStation;
- (UITableViewCell *)buildCellForSemaforo:(UITableViewCell *)theCell usingSemaforo:(NSInteger)semaforo;
@end

@implementation GasolineraController

@synthesize mapa;
@synthesize request;
@synthesize infoView;
@synthesize mapaView;
@synthesize tableView;
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
  [self loadGasStationStub];

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
  self.mapa = nil;
  self.mapaView = nil;
  self.infoView = nil;  
   
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
  [self.tableView reloadData];
  [self addGasStationToMap];
}

- (UITableViewCell *)buildCellForSemaforo:(UITableViewCell *)theCell usingSemaforo:(NSInteger)semaforo 
{
  switch (semaforo) {
    case 1:
      theCell.textLabel.text = @"Sin inconsistencias";
      theCell.imageView.image = [UIImage imageNamed:@"green_light.png"];
      break;
    case 2:
      theCell.textLabel.text = @"Algunas inconsistencias";
      theCell.imageView.image = [UIImage imageNamed:@"orange_light.png"];
      break;  
    case 3:
      theCell.textLabel.text = @"Verificación Negativa";
      theCell.imageView.image = [UIImage imageNamed:@"red_light.png"];
      break;    
    default:
      theCell.textLabel.text = @"No Verificada";
      theCell.imageView.image = [UIImage imageNamed:@"no_light.png"];
      break;
  }
  theCell.imageView.layer.masksToBounds = YES;
  theCell.imageView.layer.cornerRadius  = 5.0;  
  theCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  return theCell;
}

- (void)addGasStationToMap
{
  NSNumber *latitude  = [self.gasStation objectForKey:@"latitude"];
  NSNumber *longitude = [self.gasStation objectForKey:@"longitude"];
  CLLocationCoordinate2D coordinate;
  coordinate.latitude = latitude.doubleValue;
  coordinate.longitude = longitude.doubleValue; 
  GasStationMarker *marker = [[GasStationMarker alloc] initWithCoordinate:coordinate];
  marker.name    = [self.gasStation valueForKey:@"razonSocial"];
  marker.address = [self.gasStation valueForKey:@"direccion"];
    
  [self.mapa addAnnotation:marker];
  
  MKCoordinateSpan span;  
  
  span.latitudeDelta  = 0.005;  
  span.longitudeDelta = 0.005;
  MKCoordinateRegion region;
  region.span = span;
  region.center = coordinate;
  
  [self.mapa setRegion:region animated:NO];
  
  [self.mapa regionThatFits:region];
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

#pragma mark UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
  return self.gasStation ? 5 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
  return self.gasStation ? 1 : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *sectionTitle;
  switch (section) {
    case 0:
      sectionTitle = [self.gasStation valueForKey:@"razonSocial"];
      break;
    case 1:
      sectionTitle = @"Dirección";
      break;
    case 2:
      sectionTitle = @"Resultado Verificación";
      break;    
    case 3:
      sectionTitle = @"Teléfono";
      break;  
    case 4:
      sectionTitle = @"Denuncias en Profeco";
      break;    
    default:
      break;
  }
  return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"GasStationCell";
  UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
  switch (indexPath.section) {
    case 0:
      cell.textLabel.text = nil;
      EGOImageView *imageView = [[EGOImageView alloc] init];
      imageView.imageURL      = [NSURL URLWithString:[self.gasStation valueForKey:@"urlImg"]];
      cell.userInteractionEnabled = NO;
      cell.backgroundView     = imageView;
      break;
    case 1:
      cell.textLabel.text = [self.gasStation valueForKey:@"direccion"];
      break;  
    case 2:
      [self.gasStation objectForKey:@"semaforo"];
      NSNumber *semaforo = [self.gasStation objectForKey:@"semaforo"];
      cell = [self buildCellForSemaforo:cell usingSemaforo:[semaforo intValue]];      
      break;  
    case 3:
      cell.textLabel.text = [self.gasStation valueForKey:@"telefono"];
      cell.accessoryType  = UITableViewCellAccessoryDetailDisclosureButton;
      break;  
    case 4:
      cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.gasStation valueForKey:@"denuncias"]];
      break;  
    default:
      break;
  }  
  return cell;
}

#pragma mark UITableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
   
   if (!indexPath.section) {
     return 200;
   } else {
     return 44;
   }
 }


@end
