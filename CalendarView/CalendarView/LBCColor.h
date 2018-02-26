//
//  LBCColor.h
//  LeboncoinBackend
//
//  Created by Guillaume Mirambeau on 8/19/13.
//  Copyright (c) 2013 leboncoin.fr. All rights reserved.
//

#ifndef Leboncoin_LBCColor_h
#define Leboncoin_LBCColor_h

/*
#define	lbcPageColor						[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(235.0/255.0) alpha:1.0]
#define lbcBlue								[UIColor colorWithRed:(51.0/255.0) green:(102.0/255.0) blue:(153.0/255.0) alpha:1.0]
#define lbcGrey								[UIColor colorWithRed:(102.0/255.0) green:(102.0/255.0) blue:(120.0/255.0) alpha:1.0]
#define lbcGrey2							[UIColor colorWithRed:(80.0/255.0) green:(80.0/255.0) blue:(80.0/255.0) alpha:1.0]
#define lbcGrey3							[UIColor colorWithRed:(226.0/255.0) green:(229.0/255.0) blue:(234.0/255.0) alpha:1.0]
#define lbcAlphaOrange						[UIColor colorWithRed:(255.0/255.0) green:(127.0/255.0) blue:(0.0/255.0) alpha:0.35]
#define lbcRedColor                         [UIColor redColor]
#define lbcGrayModifyFields					lbcNavigationTextColor

#define	lbcNavigationBarColor               [UIColor colorWithRed:(227.0/255.0) green:(220.0/255.0) blue:(205.0/255.0)  alpha:1.0]
#define lbcNavigationOrangeColor            [UIColor colorWithRed:(255/255.0) green:(102/255.0) blue:(0/255.0) alpha:1.0]

#define lbcTableViewCellSeparatorColor      [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1.0]

#define lbcPulldownGrey                     [UIColor colorWithRed:(80.0/255.0) green:(80.0/255.0) blue:(80.0/255.0) alpha:1.0]

// Region color on color map
#define lbcAlsaceColor                  [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0)  alpha:1.0]
#define lbcAquitaineColor               [UIColor colorWithRed:(255.0/255.0) green:(0.0/255.0)   blue:(255.0/255.0)  alpha:1.0]
#define lbcAuvergneColor                [UIColor colorWithRed:(255.0/255.0) green:(0.0/255.0)   blue:(0.0/255.0)    alpha:1.0]
#define lbcBasseNormandieColor          [UIColor colorWithRed:(0.0/255.0)   green:(255.0/255.0) blue:(0.0/255.0)    alpha:1.0]
#define lbcBourgoneColor                [UIColor colorWithRed:(0.0/255.0)   green:(0.0/255.0)   blue:(255.0/255.0)  alpha:1.0]
#define lbcBretagneColor                [UIColor colorWithRed:(0.0/255.0)   green:(255.0/255.0) blue:(255.0/255.0)  alpha:1.0]
#define lbcCentreColor                  [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(0.0/255.0)    alpha:1.0]

#define lbcChampagneArdenneColor        [UIColor colorWithRed:(127.0/255.0) green:(127.0/255.0) blue:(127.0/255.0)  alpha:1.0]
#define lbcCorseColor                   [UIColor colorWithRed:(127.0/255.0) green:(0.0/255.0)   blue:(127.0/255.0)  alpha:1.0]
#define lbcFrancheComteColor            [UIColor colorWithRed:(127.0/255.0) green:(0.0/255.0)   blue:(0.0/255.0)    alpha:1.0]
#define lbcHauteNormandieColor          [UIColor colorWithRed:(0.0/255.0)   green:(127.0/255.0) blue:(0.0/255.0)    alpha:1.0]
#define lbcIleDeFranceColor             [UIColor colorWithRed:(0.0/255.0)   green:(0.0/255.0)   blue:(127.0/255.0)  alpha:1.0]
#define lbcLanguedocRoussillonColor     [UIColor colorWithRed:(0.0/255.0)   green:(127.0/255.0) blue:(127.0/255.0)  alpha:1.0]
#define lbcLimousinColor                [UIColor colorWithRed:(127.0/255.0) green:(127.0/255.0) blue:(0.0/255.0)    alpha:1.0]

#define lbcLorraineColor                [UIColor colorWithRed:(64.0/255.0)  green:(64.0/255.0)  blue:(64.0/255.0)   alpha:1.0]
#define lbcMidiPyreneesColor            [UIColor colorWithRed:(64.0/255.0)  green:(0.0/255.0)   blue:(64.0/255.0)   alpha:1.0]
#define lbcNordPasDeCalaisColor         [UIColor colorWithRed:(64.0/255.0)  green:(0.0/255.0)   blue:(0.0/255.0)    alpha:1.0]
#define lbcPaysDeLaLoireColor           [UIColor colorWithRed:(0.0/255.0)   green:(64.0/255.0)  blue:(0.0/255.0)    alpha:1.0]
#define lbcPicardieColor                [UIColor colorWithRed:(0.0/255.0)   green:(0.0/255.0)   blue:(64.0/255.0)   alpha:1.0]
#define lbcPoitouCharentesColor         [UIColor colorWithRed:(0.0/255.0)   green:(64.0/255.0)  blue:(64.0/255.0)   alpha:1.0]
#define lbcProvenceAlpesCoteAzurColor   [UIColor colorWithRed:(64.0/255.0)  green:(64.0/255.0)  blue:(0.0/255.0)    alpha:1.0]

#define lbcRhoneAlpesColor              [UIColor colorWithRed:(190.0/255.0) green:(190.0/255.0) blue:(190.0/255.0)  alpha:1.0]
#define lbcGuadeloupeColor              [UIColor colorWithRed:(190.0/255.0) green:(0.0/255.0)   blue:(190.0/255.0)  alpha:1.0]
#define lbcGuyaneColor                  [UIColor colorWithRed:(190.0/255.0) green:(0.0/255.0)   blue:(0.0/255.0)    alpha:1.0]
#define lbcLaReunionColor               [UIColor colorWithRed:(0.0/255.0)   green:(190.0/255.0) blue:(0.0/255.0)    alpha:1.0]
#define lbcMartiniqueColor              [UIColor colorWithRed:(0.0/255.0)   green:(0.0/255.0)   blue:(190.0/255.0)  alpha:1.0]

// InsertAd
#define lbcDepotSectionTitleGrey		[UIColor colorWithRed:(102.0/255.0) green:(102.0/255.0) blue:(120.0/255.0) alpha:1.0]
*/

//NEw Color

#define C1              [UIColor colorWithRed:(227.0/255.0) green:(220.0/255.0) blue:(205.0/255.0) alpha:1.0]
#define	C2              [UIColor colorWithRed:(247.0/255.0) green:(104.0/255.0) blue:(0.0/255.0) alpha:1.0]

#define C3              [UIColor colorWithRed:(239.0/255.0) green:(157.0/255.0) blue:(112.0/255.0) alpha:1.0]
#define	C4              [UIColor colorWithRed:(51.0/255.0) green:(102.0/255.0) blue:(153.0/255.0) alpha:1.0]

#define C5              [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(235.0/255.0) alpha:1.0]
#define	C6              [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1.0]

#define C7              [UIColor colorWithRed:(197.0/255.0) green:(193.0/255.0) blue:(184.0/255.0) alpha:1.0]

#define	C8              [UIColor colorWithRed:(152.0/255.0) green:(144.0/255.0) blue:(132.0/255.0) alpha:1.0]
#define	C8T             [UIColor colorWithRed:(152.0/255.0) green:(144.0/255.0) blue:(132.0/255.0) alpha:0.5]

#define C9              [UIColor colorWithRed:(83.0/255.0) green:(86.0/255.0) blue:(92.0/255.0) alpha:1.0]

#define	C10             [UIColor colorWithRed:(63.0/255.0) green:(63.0/255.0) blue:(68.0/255.0) alpha:1.0]

#define C11             [UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0) alpha:1.0]


#define C999            [UIColor clearColor]
//


#define lbcNavigationTextColor                      [UIColor colorWithRed:(152/255.0) green:(144/255.0) blue:(132/255.0) alpha:1.0]



// Generic
#define LBC_BLACK_COLOR                             [UIColor blackColor]
#define LBC_ORANGE_COLOR                            [UIColor colorWithRed:(255.0/255.0) green:(127.0/255.0) blue:(0.0/255.0) alpha:1.0]
#define	LBC_YELLOW_COLOR                            [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(235.0/255.0) alpha:1.0]
#define LBC_WHITE_COLOR                             [UIColor whiteColor]
//#define LBC_GREY_COLOR                              [UIColor colorWithRed:(102.0/255.0) green:(102.0/255.0) blue:(120.0/255.0) alpha:1.0]
#define LBC_BLUE_COLOR                              [UIColor colorWithRed:(51.0/255.0) green:(102.0/255.0) blue:(153.0/255.0) alpha:1.0]
#define LBC_GREY_COLOR                              [UIColor colorWithRed:(153.0/255.0) green:(153.0/255.0) blue:(153.0/255.0) alpha:1.0]
#define LBC_LIGHT_GREY_COLOR                        [UIColor lightGrayColor]
#define LBC_RED_COLOR                               [UIColor redColor]


#define LBC_NAVIGATION_BAR_TITLE_COLOR              [UIColor colorWithRed:(152.0/255.0) green:(144.0/255.0) blue:(132.0/255.0) alpha:1.0]
#define LBC_NAVIGATION_BAR_TINT_COLOR               [UIColor colorWithRed:(255.0/255.0) green:(102.0/255.0) blue:(0.0/255.0) alpha:1.0]
#define LBC_NAVIGATION_BAR_TINT_ALPHA_COLOR         [UIColor colorWithRed:(255.0/255.0) green:(127.0/255.0) blue:(0.0/255.0) alpha:0.35]

#define LBC_TABLEVIEW_DEFAULT_BACKGROUND_COLOR      [UIColor clearColor]

// Menu
// ../Cell

//#define LBC_MENU_CELL_COLOR                         [UIColor colorWithRed:(63.0/255.0) green:(63.0/255.0) blue:(68.0/255.0)  alpha:1.0]
//#define LBC_MENU_CELL_TEXT_COLOR                  [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0)  alpha:1.0]
//#define LBC_MENU_COUNT_AD_TEXT_COLOR              [UIColor colorWithRed:(156.0/255.0) green:(156.0/255.0) blue:(156.0/255.0)  alpha:1.0]
#define LBC_MENU_SEPARATOR_CELL_COLOR               [UIColor colorWithRed:(156.0/255.0) green:(156.0/255.0) blue:(156.0/255.0)  alpha:1.0]
// ../Header
//#define LBC_MENU_BACKGROUND_COLOR                   [UIColor colorWithRed:(83.0/255.0) green:(86.0/255.0) blue:(92.0/255.0)  alpha:1.0]
#define LBC_MENU_HEADER_TEXT_COLOR                  [UIColor colorWithRed:(156.0/255.0) green:(156.0/255.0) blue:(156.0/255.0)  alpha:1.0]

// Listing

#define LBC_LISTNG_COUNT_TEXT_COLOR                 LBC_NAVIGATION_BAR_TITLE_COLOR
#define LBC_LISTNG_DATE_COLOR                       LBC_GREY_COLOR
#define LBC_LISTNG_PRICE_COLOR                      LBC_BLACK_COLOR
#define LBC_LISTNG_CATEGORY_COLOR                   LBC_BLUE_COLOR
#define LBC_LISTNG_CITY_COLOR                       LBC_BLUE_COLOR
//#define LBC_LISTNG_IN_TITLE_BACKGROUND_COLOR        [UIColor colorWithRed:(0.0/255.0) green:(0.0/255.0) blue:(0.0/255.0)  alpha:0.75]

// AdView
#define LBC_ADVIEW_DATE_CRITERION_COLOR             [UIColor colorWithRed:(153.0/255.0) green:(153.0/255.0) blue:(153.0/255.0) alpha:1.0]
#define LBC_ADVIEW_PRICE_TITLE_CRITERION_COLOR      LBC_BLACK_COLOR

#define LBC_ADVIEW_SPECIFIC_CRITERIA_COLOR          LBC_BLACK_COLOR
#define LBC_ADVIEW_BODY_CRITERION_COLOR             LBC_BLACK_COLOR

// Dashboard
//#define LBC_DISABLE_GREY                            [UIColor colorWithRed:197.0/256.0 green:193.0/256.0 blue:184.0/256.0 alpha:1.0]
#define LBC_DASHBOARD_COUNT_COLOR                   LBC_GREY_COLOR

// Modify
#define LBC_MODIFY_GREY_FIELD                       LBC_NAVIGATION_BAR_TITLE_COLOR

#endif