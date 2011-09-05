//
//  MunicipioController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MunicipioController.h"

#import "JSON.h"
#import "Constants.h"
#import "GasolinerasController.h"

@interface MunicipioController ()

- (void)loadMunicipios;
- (void)loadMunicipiosStub;
- (void)updateMunicipios:(NSString *)jsonMunicipios;

@end

@implementation MunicipioController

@synthesize municipios;
@synthesize request;
@synthesize estado;

-(id)initWithEstado:(NSInteger)state {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.title  = @"Municipios";
    self.estado = state; 
    self.municipios = [NSArray array];
  }
  return self;
}


- (void)dealloc
{
  [request clearDelegatesAndCancel];
  [request release];
  [municipios release];
  [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadMunicipiosStub];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

#pragma mark private methods
- (void)loadMunicipios
{
  NSString *urlRequest = [NSString stringWithFormat:MUNICIPIOS_SERVICE_URL, [NSNumber numberWithInteger:self.estado]];
  NSLog(@"urlRequest %@", urlRequest);
  request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlRequest]];
  [request setDelegate:self];
  [request startSynchronous]; 
}

- (void)loadMunicipiosStub 
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"municipios" ofType:@"json"];
  
  [self updateMunicipios:[NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil]];
}

- (void)updateMunicipios:(NSString *)jsonMunicipios
{
  self.municipios = [jsonMunicipios JSONValue];
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.municipios count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
    
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  NSDictionary *municipio = [self.municipios objectAtIndex:indexPath.row];
  cell.textLabel.text = [municipio valueForKey:@"desc"];
    
  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  return cell;
}

#pragma mark - ASIHTTPRequest Delegate Methods

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{
  
  [self updateMunicipios:[theRequest responseString]];
  
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
  NSError *error = [theRequest error];
  NSLog(@"Error %@", error);
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{       
  
  NSDictionary *municipio = [self.municipios objectAtIndex:indexPath.row];
  NSNumber *idMunicipio   = [municipio objectForKey:@"id"];
  GasolinerasController *detailViewController = [[GasolinerasController alloc] 
                                                 initWithMunicipio:[idMunicipio integerValue]];
  
  [self.navigationController pushViewController:detailViewController animated:YES];
  [detailViewController release];
     
}

@end
