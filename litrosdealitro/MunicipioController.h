//
//  MunicipioController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface MunicipioController : UITableViewController {
    
  NSInteger estado;
  NSArray *municipios;
  ASIHTTPRequest *request;
  
}


@property(nonatomic, assign) NSInteger estado;
@property(nonatomic, retain) NSArray *municipios;
@property(nonatomic, retain) ASIHTTPRequest *request;

-(id)initWithEstado:(NSInteger)state;

@end
