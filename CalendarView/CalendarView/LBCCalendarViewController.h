//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, DayState){
    dayStateUnactive,
    dayStateUnselected,
    dayStateFirstSelected,
    dayStateSelected,
    dayStateLastSelected
};


@class LBCCalendarObject;

@interface LBCDayView : UIView
@property (nonatomic, assign) DayState dayState;
@property (nonatomic, strong) IBOutlet UILabel *dayLabel;
@property (nonatomic, strong) NSDateComponents *dateComponents;
@property (nonatomic, strong) UIView *selectedView;
- (id) initWithComponent:(NSDateComponents *)component
             andDayState:(DayState)dayState
                andFrame:(CGRect)frame;
@end


@interface LBCMonthView : UIView
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) LBCCalendarObject *calendarObject;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGFloat xPosition;
@property (nonatomic, assign) CGFloat yPosition;
@end


@interface LBCCalendarHeaderView : UIView
@property (nonatomic, strong) UILabel *monthLabel;
- (id)initWithFrame:(CGRect)frame andCalendarObject:(LBCCalendarObject *)calendarObject;
@end


@interface LBCCalendarObject : NSObject
@property (nonatomic, assign) NSInteger firstDayOfLastMonth;
@property (nonatomic, assign) NSInteger maxDayOfLastMonth;
@property (nonatomic, assign) NSInteger maxDayOfCurrentMonth;
@property (nonatomic, strong) LBCMonthView *monthView;
@property (nonatomic, strong) LBCCalendarHeaderView *headerView;
@property (nonatomic, assign) NSInteger currentMonth;
- (void) addSelectionFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;
-(UIView *) buildCalendarViewInFrame:(CGRect) frame;
- (NSString *)getCurrentMonthName;
@end



@interface LBCCalendarViewController : UIViewController
@property (nonatomic, strong) LBCCalendarObject *calendarObject;
@end
