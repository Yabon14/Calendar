//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>



#define SELECTED_HEIGHT_COEFF       0.8f    // height of selection = cell height * SELECTED_HEIGHT_COEFF
#define TITLE_HEADER_COEFF          2/3     // height of month label = height of hedaer view * TITLE_HEADER_COEFF
#define RADIUS_CELL                 25      // For curve effect on selection

#define LEFT_ARROW_TAG              1000
#define RIGHT_ARROW_TAG             1001

#define MAX_WEEK_PER_MONTH          6
#define MAX_DAY_PER_WEEK            7

typedef NS_ENUM (NSInteger, DayState){
    dayStateUnactive,
    dayStateUnselected,
    dayStateFirstSelected,
    dayStateSelected,
    dayStateLastSelected,
    dayStateBothSelected
};


@class LBCCalendarHeaderView, LBCMonthView;


@interface LBCSelection : NSObject
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
- (id) initWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;
@end


@interface LBCCalendarObject : NSObject
@property (nonatomic, assign) NSInteger firstDayOfLastMonth;
@property (nonatomic, assign) NSInteger maxDayOfLastMonth;
@property (nonatomic, assign) NSInteger maxDayOfCurrentMonth;
@property (nonatomic, strong) LBCMonthView *monthView;
@property (nonatomic, strong) LBCCalendarHeaderView *headerView;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, strong) NSArray * selectionArray;

/**
 *  Add an array of LBCSelection. Display selection automatically
 *
 *  @param selectionArray array of LBCSelection
 */
- (void) addSelectionArray:(NSArray *)selectionArray;


/**
 *  Add a selection from start date to end date
 *
 *  @param startDate start of the selection
 *  @param endDate   end of the selection
 */
- (void) addSelectionFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;


/**
 *  Build a calendar view insiode the frame given
 *
 *  @param frame
 *
 *  @return calendar view
 */
- (UIView *) buildCalendarViewInFrame:(CGRect) frame;



- (NSString *)getCurrentMonthName;

@end
