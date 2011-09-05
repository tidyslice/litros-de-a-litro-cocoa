//
//  EstadoController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EstadoController.h"

#import "Json.h"
#import "Constants.h"
#import "MunicipioController.h"

@interface EstadoController ()

- (void)loadEstados;
- (void)loadEstadosStub;
- (void)updateEstados:(NSString *)jsonEstados;

@end

@implementation EstadoController

@synthesize estados;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      self.title   = @"Estados";
      //self.estados = [NSArray array];
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
- (void)loadEstadosStub {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"estados" ofType:@"json"];

  [self updateEstados:[NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil]];
}
- (void)updateEstados:(NSString *)jsonEstados 
{    
  self.estados = [jsonEstados JSONValue];
  [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self loadEstadosStub];
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

  return [self.estados count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
    
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                     reuseIdentifier:CellIdentifier] autorelease];
  }
  NSDictionary *estado = [self.estados objectAtIndex:indexPath.row];
  cell.textLabel.text = [estado valueForKey:@"desc"];
  cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    
  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  NSDictionary *chosenState = [self.estados objectAtIndex:indexPath.row];
  NSNumber *idState = [chosenState objectForKey:@"id"];

  MunicipioController *municipioController = [[MunicipioController alloc] 
                                                initWithEstado:[idState integerValue]];
  [self.navigationController pushViewController:municipioController animated:YES];
  [municipioController release];
  
}


#pragma mark - ASIHTTPRequest Delegate Methods

- (void)requestFinished:(ASIHTTPRequest *)theRequest
{

  [self updateEstados:[theRequest responseString]];
  
}

- (void)requestFailed:(ASIHTTPRequest *)theRequest
{
  NSError *error = [theRequest error];
  NSLog(@"Error %@", error);
}

@end
