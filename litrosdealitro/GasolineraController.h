//
//  GasolineraController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GasolineraController : UIViewController {
    
    UIView* infoView;
    UIView* mapaView;
    UIImageView *gasFoto;
}

@property(nonatomic, retain) IBOutlet UIView* infoView;
@property(nonatomic, retain) IBOutlet UIView* mapaView;
@property(nonatomic, retain) IBOutlet UIImageView *gasFoto;


-(IBAction)togglePanels:(id)sender;

@end
