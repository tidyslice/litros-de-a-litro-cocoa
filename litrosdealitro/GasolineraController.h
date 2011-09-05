//
//  GasolineraController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 09/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

@interface GasolineraController : UIViewController 
{
      
  UIView* infoView;
  UIView* mapaView;
  NSString *stationId;
  UIImageView *gasFoto;  
  
  ASIHTTPRequest *request;
  NSDictionary *gasStation;
  
}

@property(nonatomic, retain) NSString *stationId;
@property(nonatomic, retain) ASIHTTPRequest *request;
@property(nonatomic, retain) NSDictionary *gasStation;
@property(nonatomic, retain) IBOutlet UIView* infoView;
@property(nonatomic, retain) IBOutlet UIView* mapaView;
@property(nonatomic, retain) IBOutlet UIImageView *gasFoto;

- (id)initWithGasStation:(NSString *)theId;
- (IBAction)togglePanels:(id)sender;


@end
