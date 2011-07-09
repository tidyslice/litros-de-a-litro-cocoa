//
//  MunicipioController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MunicipioController : UITableViewController {
    NSString *estado;
    NSArray *municipios;
}


@property(nonatomic, retain) NSString *estado;
@property(nonatomic, retain) NSArray *municipios;


-(id)initWithEstado:(NSString *)state;

@end
