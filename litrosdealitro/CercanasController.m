//
//  CercanasController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CercanasController.h"

#import "JSON.h"
#import "Constants.h"
#import "GasolineraController.h"
#import <QuartzCore/QuartzCore.h>

@interface  CercanasController ()


- (void)loadGasolinerasStub;
- (void)updateGasolineras:(NSString *)jsonGasolineras;
- (void)loadGasolinerasInLatitude:(double)latitude andLongitude:(double)longitude;

@end

@implementation CercanasController

@synthesize gasolineras;
@synthesize request;
@synthesize locationManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      self.title = @"Cercanas";
      self.locationManager = [[[CLLocationManager alloc] init] autorelease];
      self.locationManager.delegate = self; 
    }
    return self;
}

- (void)dealloc
{
  [gasolineras release];
  [locationManager release];
  [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [locationManager startUpdatingLocation];

}

#pragma mark private methods

- (void)loadGasolinerasInLatitude:(double)latitude andLongitude:(double)longitude
{
  NSString *urlRequest = [NSString stringWithFormat:NEARBY_STATIONS_SERVICE_URL, 
                          [NSNumber numberWithDouble:latitude],
                          [NSNumber numberWithDouble:longitude],
                          @"10",
                          @"10"];
  NSLog(@"urlRequest %@", urlRequest);
  request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlRequest]];
  [request setDelegate:self];
  [request startSynchronous]; 
}

- (void)loadGasolinerasStub
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"json"];
  
  [self updateGasolineras:[NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil]];
}

- (void)updateGasolineras:(NSString *)jsonGasolineras
{
  self.gasolineras = [jsonGasolineras JSONValue];
  [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
  return [self.gasolineras count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] 
            autorelease];
  }
  
  NSDictionary *gasolinera = [self.gasolineras objectAtIndex:indexPath.row];
  cell.textLabel.text =  [NSString stringWithFormat:@"Estación %@", [gasolinera objectForKey:@"id"]];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ kms", [gasolinera objectForKey:@"distancia"]];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  NSNumber *semaforo = [gasolinera objectForKey:@"semaforo"];
  switch ([semaforo intValue]) {
    case 1:
      cell.imageView.image = [UIImage imageNamed:@"green_light.png"];
      
      break;
    case 2:
      cell.imageView.image = [UIImage imageNamed:@"orange_light.png"];
      
      break;
    case 3:
      cell.imageView.image = [UIImage imageNamed:@"red_light.png"];
      break;  
    default:
      cell.imageView.image = [UIImage imageNamed:@"no_light.png"];     
      break;
  }
  cell.imageView.layer.masksToBounds = YES;
  cell.imageView.layer.cornerRadius  = 5.0;
  
  return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *station = [self.gasolineras objectAtIndex:indexPath.row];
  
  
  GasolineraController *detailViewController = [[GasolineraController alloc] initWithGasStation:@"E00333"];
  
  [self.navigationController pushViewController:detailViewController animated:YES];
  [detailViewController release];
  
}

#pragma mark CLocation Delegate Methods

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
  NSLog(@"updated %f %f ", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
  [locationManager stopUpdatingLocation];
  [self loadGasolinerasInLatitude:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                 message:@"No se pudo obtener la posición actual" 
                                                delegate:nil 
                                       cancelButtonTitle:@"OK" 
                                       otherButtonTitles:nil];
  [alert show];
  [alert release];
}

#pragma mark ASIHTTPRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
  
  [self updateGasolineras:[theRequest responseString]];
  
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
  NSError *error = [theRequest error];
  NSLog(@"Error %@", error);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                  message:@"Error conectándose al servidor" 
                                                 delegate:nil 
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles:nil];
  [alert show];
  [alert release];
}


@end
