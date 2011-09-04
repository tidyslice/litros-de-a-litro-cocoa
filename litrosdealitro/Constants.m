//
//  Constants.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 03/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"

NSString * const ESTADOS_SERVICE_URL          = @"http://178.63.61.196:8989/temp-gasolineras-back/v1/getEstados";

NSString * const STATION_SERVICE_URL          = @"http://178.63.61.196:8989/temp-gasolineras-back/v1/getDetailGasStation?id=%@"; 

NSString * const MUNICIPIOS_SERVICE_URL       = @"http://178.63.61.196:8989/temp-gasolineras-back/v1/getMuniciposDelegacion?id=%@";

NSString * const NEARBY_STATIONS_SERVICE_URL  = @"http://178.63.61.196:8989/temp-gasolineras-back/v1/getNearGasStation?lt=%@&ln=-%@&d=%@&l=%@";

@implementation Constants

@end
