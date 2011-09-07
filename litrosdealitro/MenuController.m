//
//  RootViewController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "EstadoController.h"
#import "CercanasController.h"

@implementation MenuController

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    icons = [[NSArray arrayWithObjects:@"search_icon.png", @"cercanas_icon.png", @"price_icon.png",
            @"info_icon.png", nil] retain];
    titles = [[NSArray arrayWithObjects:@"Buscar",@"Cercanas",@"Precios",@"Info", nil] retain];
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Litros de a litro";
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

	return YES;
}
 
#pragma mark UITableView DataSource Methods
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Elige una opción";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
   
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
    
  cell.imageView.image = [UIImage imageNamed:[icons objectAtIndex:indexPath.row]];
  cell.textLabel.text = [titles objectAtIndex:indexPath.row];
  cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.row == 0) {
            
      UIViewController *estadoController = [[EstadoController alloc] initWithStyle:UITableViewStyleGrouped];
      [self.navigationController pushViewController:estadoController animated:YES];
      [estadoController release];
    } else if (indexPath.row == 1) {
      UIViewController *cercanasController = [[CercanasController alloc] initWithStyle:UITableViewStyleGrouped];
      [self.navigationController pushViewController:cercanasController animated:YES];
      [cercanasController release];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{ 
  [icons release];
  [titles release];
  [super dealloc];
}

@end
