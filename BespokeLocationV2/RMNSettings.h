//
//  RMNSettings.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#ifndef BespokeLocationV2_RMNSettings_h
#define BespokeLocationV2_RMNSettings_h

// test if the curred device is iphone 5, 5s
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// test if the curred device is a iphone device
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )

// test if the curred device is a ipod device
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

// test if the curred device is orientated to a landscape format
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#endif
