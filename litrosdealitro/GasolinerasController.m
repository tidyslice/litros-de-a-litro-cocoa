//
//  GasolinerasController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GasolinerasController.h"

#import "JSON.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "GasolineraController.h"

@interface  GasolinerasController ()

- (void)loadGasolineras;
- (void)loadGasolinerasStub;
- (void)updateGasolineras:(NSString *)jsonGasolineras;


@end

@implementation GasolinerasController

@synthesize request;
@synthesize municipio;
@synthesize gasolineras;

- (id)initWithMunicipio:(NSInteger)theMunicipio 
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.title = @"Gasolineras";
  }
  return self;
}

- (void)dealloc
{
    [gasolineras release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadGasolinerasStub];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark private methods

- (void)loadGasolineras
{
  
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.gasolineras count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
    
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {

    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
    
  NSDictionary *gasolinera = [self.gasolineras objectAtIndex:indexPath.row];
  cell.textLabel.text =  [NSString stringWithFormat:@"Estación %@", [gasolinera objectForKey:@"id"]];
  cell.detailTextLabel.text = [gasolinera objectForKey:@"direccion"];
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

@end
