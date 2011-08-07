//
//  GasolineraController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GasolineraController.h"


@implementation GasolineraController

@synthesize infoView;
@synthesize mapaView;
@synthesize gasFoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [infoView release];
    [mapaView release];
    [gasFoto release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    // Do any additional setup after loading the view from its nib.
    UISegmentedControl *toggleViewControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Info", @"Mapa", nil]];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
