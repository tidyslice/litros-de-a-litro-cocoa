//
//  GasolinerasController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

@interface GasolinerasController : UITableViewController 
{
  NSInteger municipio;
  NSArray *gasolineras;    
  
}

@property(nonatomic, assign) NSInteger municipio;
@property(nonatomic, retain) NSArray *gasolineras;
@property(nonatomic, retain) ASIHTTPRequest *request;

- (id)initWithMunicipio:(NSInteger)theMunicipio;

@end
