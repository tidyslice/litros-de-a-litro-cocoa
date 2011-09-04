//
//  EstadoController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EstadoController.h"

#import "Constants.h"
#import "MunicipioController.h"

@interface EstadoController ()

- (void)loadEstados;

@end

@implementation EstadoController

@synthesize estados;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title   = @"Estados";
        self.estados = [NSArray arrayWithObjects:@"Aguascalientes",@"Baja California",@"Baja California Sur",@"Campeche",@"Chiapas",@"Chihuahua",@"Coahuila",@"Colima",@"Distrito Federal",@"Durango",@"Estado de México",@"Guanajuato",@"Guerrero",@"Hidalgo",@"Jalisco",@"Michoacán",@"Morelos",@"Nayarit",@"Nuevo León",@"Oaxaca",@"Puebla",@"Querétaro",@"Quintana Roo",@"San Luis Potosí",@"Sinaloa",@"Sonora",@"Tabasco",@"Tamaulipas",@"Tlaxcala",@"Veracruz",@"Yucatán",@"Zacatecas", nil];
    }
    return self;
}

- (void)dealloc
{
  [estados release];
  [request clearDelegatesAndCancel];
  [request release];
  [super dealloc];
    
}

#pragma mark - Private methods

- (void)loadEstados 
{
  request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:ESTADOS_SERVICE_URL]];
  [request setDelegate:self];
  [request startSynchronous]; 
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [estados count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.estados objectAtIndex:indexPath.row];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *chosenState = [self.estados objectAtIndex:indexPath.row];
    
    MunicipioController *municipioController = [[MunicipioController alloc] initWithEstado:chosenState];
     [self.navigationController pushViewController:municipioController animated:YES];
     [municipioController release];
   
}

#pragma mark - ASIHTTPRequest Delegate Methods

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{

  NSString *responseString = [theRequest responseString];
  
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
  NSError *error = [theRequest error];
}

@end
