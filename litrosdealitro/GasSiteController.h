//
//  GasSiteController.h
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



@interface GasSiteController : UIViewController
{
  UIWebView *webView;
  NSString *gasStationUrl;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *gasStationUrl;

- (id)initWitSiteUrl:(NSString *)theUrl;

@end
