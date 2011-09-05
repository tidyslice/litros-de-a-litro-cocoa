//
//  EstadoController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface EstadoController : UITableViewController {
  
  ASIHTTPRequest *request;
  NSArray *estados;
    
}

@property(nonatomic, retain) NSArray *estados;

@end
