//
//  GasSiteController.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GasSiteController.h"

@implementation GasSiteController

@synthesize webView;
@synthesize gasStationUrl;

- (id)initWitSiteUrl:(NSString *)theUrl
{
    self = [super initWithNibName:@"GasSiteController" bundle:nil];
    if (self) {
      self.gasStationUrl = theUrl;
    }
    return self;
}

- (void)dealloc
{
  [webView release];
  [gasStationUrl release];
  [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  NSLog(@"url %@", self.gasStationUrl);
  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.gasStationUrl]]];

}

- (void)viewDidUnload
{
  [super viewDidUnload];
  self.webView = nil;
}


@end
