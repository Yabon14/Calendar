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
#define RADIUS_CELL_COEFF           0.5f    // For curve effect on selection

#define LEFT_ARROW_TAG              2000
#define RIGHT_ARROW_TAG             2001

#define MAX_WEEK_PER_MONTH          6
#define MAX_DAY_PER_WEEK            7

#define CELL_HEIGHT                 44.f


//Define in Tools
#define F1             [UIFont systemFontOfSize:11.0f]
#define F2             [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f]
#define F3             [UIFont fontWithName:@"HelveticaNeue-Medium" size:13.0f]
#define F4             [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0f]
#define F5             [UIFont systemFontOfSize:12.0f]
#define F6             [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0f]
#define F7             [UIFont systemFontOfSize:14.0f]
#define F8             [UIFont boldSystemFontOfSize:16.0f]
#define F9             [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f]
#define F10            [UIFont systemFontOfSize:16.0f]
#define F11            [UIFont systemFontOfSize:16.0f]
#define F12            [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]
#define F13            [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f]
#define F14            [UIFont italicSystemFontOfSize:14.0f]
#define F15            [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]
#define F16            [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]

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

typedef NS_ENUM (NSInteger, DayState){
    dayStateUnactive,
    dayStateUnselected,
    dayStateFirstSelected,
    dayStateSelected,
    dayStateLastSelected,
    dayStateBothSelected
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
@property (nonatomic, strong) LBCCalendarView *calendarView;

@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, strong) NSDate *dateMin;
@property (nonatomic, strong) NSDate *dateMax;
@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSArray * selectionArray;
@property (nonatomic, strong) NSArray * selectionCurrentMonthArray;

@property (nonatomic, weak) id <CalendarDelegate> delegate;


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



@end
