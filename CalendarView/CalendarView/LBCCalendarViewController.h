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
@property (nonatomic, assign) CGFloat startYPos;
- (id) initWithMonthName:(NSString *)monthName
     firstDayOnLastMonth:(NSInteger)firstDayOfLastMonth
       maxDayOfLastMonth:(NSInteger)maxDayOfLastMonth
    maxDayOfCurrentMonth:(NSInteger)maxDayOfCurrentMonth
                andFrame:(CGRect)frame;
@end


@interface LBCCalendarHeaderView : UIView
- (id)initWithFrame:(CGRect)frame andCalendarObject:(LBCCalendarObject *)calendarObject;
@end


@interface LBCCalendarObject : NSObject
@property (nonatomic, strong) LBCMonthView *monthView;
@property (nonatomic, strong) LBCCalendarHeaderView *headerView;
@property (nonatomic, assign) NSInteger currentMonth;
- (void) addSelectionFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;
-(UIView *) buildCalendarViewInFrame:(CGRect) frame;
@end



@interface LBCCalendarViewController : UIViewController
@property (nonatomic, strong) LBCCalendarObject *calendarObject;
@end
