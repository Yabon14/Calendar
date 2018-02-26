//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>



#define SELECTED_HEIGHT_COEFF               0.8f    // height of selection = cell height * SELECTED_HEIGHT_COEFF
#define TITLE_HEADER_COEFF                  2/3     // height of month label = height of hedaer view * TITLE_HEADER_COEFF
#define RADIUS_CELL_COEFF                   0.5f    // For curve effect on selection

#define LEFT_ARROW_TAG                      2000
#define RIGHT_ARROW_TAG                     2001

#define MAX_WEEK_PER_MONTH                  6
#define MAX_DAY_PER_WEEK                    7

#define CELL_HEIGHT                         44.f

#define CELL_MARGIN                         10.f

#define DAY_VIEW_SELECTED_COLOR_OPACITY     0.8f


typedef NS_ENUM (NSInteger, DayState){
    dayStateUnactive,
    dayStateUnselected,
    dayStateFirstSelected,
    dayStateSelected,
    dayStateLastSelected,
    dayStateBothSelected,
    dayStateOneDaySelected
};


typedef NS_ENUM(NSInteger, WeekDay){
    weekDaySunday = 1,
    weekDayMonday,
    weekDayTuesday,
    weekDayWednesday,
    weekDayThursday,
    weekDayFriday,
    weekDaySaturday,
};

@protocol CalendarDelegate <NSObject>

- (void) calendarFrameHasChangedOfFrame:(CGRect)frame;

@end


@class LBCCalendarView;


@interface LBCSelection : NSObject
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, assign) NSInteger price;
- (id) initWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate andPrice:(NSInteger)price;
@end


@interface LBCCalendarObject : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSInteger firstDayOfLastMonth;
@property (nonatomic, assign) NSInteger maxDayOfLastMonth;
@property (nonatomic, assign) NSInteger maxDayOfCurrentMonth;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) UIFont *monthFont;
@property (nonatomic, strong) UIFont *weekDayFont;
@property (nonatomic, strong) UIFont *dayNumberFont;


#pragma mark - Proteccted

- (NSString *)getCurrentMonthYearName;




#pragma mark - Build calendar

/**
 *  build a calendarView in view and add delegate and an array of LBCSelection
 *
 *  @param view           superview of calendarView
 *  @param delegate       delegate of calendarObject (to get the new height of the view when you change month)
 *  @param selectionArray array of LBCSelection
 */
- (void) buildCalendarViewInView:(UIView *)view withDelegate:(id)delegate andSelectionArray:(NSArray *)selectionArray;

- (void) setCalendarBackgroundColor:(UIColor *)backgroundColor;



@end
