//
//  RMNSettings.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#ifndef BespokeLocationV2_RMNSettings_h
#define BespokeLocationV2_RMNSettings_h


// returns the frame of the screen
#define SCREEN_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

// return the screens height
#define SCREEN_HEIGHT ( double )[ [ UIScreen mainScreen ] bounds ].size.height

// returns screens width
#define SCREEN_WIDTH  ( double )[ [ UIScreen mainScreen ] bounds ].size.width

// test if the curred device is iphone 5, 5s
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// test if the curred device is a iphone device
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )

// test if the curred device is a ipod device
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

// test if the curred device is orientated to a landscape format
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )



// side menu pages navigation bar color
#define SIDE_MENU_PAGES_NAVBAR_COLOR [UIColor colorWithHexString:@"616161"]

// cell height
#define SIDE_MENU_ROW_HEIGHT 47

// light gray which will be used through the app
#define CELL_LIGHT_GRAY [UIColor colorWithHexString:@"f6f5f5"]

// heavy gray which will be used through the app
#define CELL_HEAVY_GRAY [UIColor colorWithHexString:@"939498"]

// dark gray which will be used through the app
#define CELL_DARK_GRAY  [UIColor colorWithHexString:@"494949"]

// light blue which will be used through the app
#define CELL_LIGHT_BLUE [UIColor colorWithHexString:@"2980b9"]


#endif
