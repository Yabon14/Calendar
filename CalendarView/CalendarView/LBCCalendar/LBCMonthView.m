//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCMonthView.h"
#import "LBCDayView.h"
#import "LBCCalendarObject.h"


@implementation LBCMonthView

- (id) initWithCalendarObject:(LBCCalendarObject *)calendarObject andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        self.calendarObject = calendarObject;
        CGFloat width = self.frame.size.width / MAX_DAY_PER_WEEK;
        CGFloat height = self.frame.size.height / MAX_WEEK_PER_MONTH;
        self.size = height < width ? height : width;
        self.xPosition = self.frame.size.width * 0.5f - self.size * MAX_DAY_PER_WEEK * 0.5f;
        self.yPosition = self.frame.size.height * 0.5f - self.size * MAX_WEEK_PER_MONTH * 0.5f;
    }
    return self;
}

- (void) refreshView{
    
    for (UIView* v in self.subviews){
        [v removeFromSuperview];
    }
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    for (int week = 0 ; week < MAX_WEEK_PER_MONTH; week++) {
        for (int weekDay = 0 ; weekDay < MAX_DAY_PER_WEEK; weekDay++) {
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setMonth:self.calendarObject.currentMonth];
            NSDate *dateForCurrentMonth = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
            NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:dateForCurrentMonth];
            components.weekday = weekDay;
            NSInteger monthDay = week * MAX_DAY_PER_WEEK + weekDay;
            
            NSInteger currentDay;
            DayState dayState = dayStateUnselected;
            BOOL isLastDayInMonth = NO;
            
            if (self.calendarObject.firstDayOfLastMonth + monthDay <= self.calendarObject.maxDayOfLastMonth){
                components.month--;
                currentDay = self.calendarObject.firstDayOfLastMonth + monthDay;
                dayState = dayStateUnactive;
            }
            else {
                currentDay = monthDay - (self.calendarObject.maxDayOfLastMonth - self.calendarObject.firstDayOfLastMonth);
                if (currentDay == self.calendarObject.maxDayOfCurrentMonth){
                    isLastDayInMonth = YES;
                }
                else if (currentDay > self.calendarObject.maxDayOfCurrentMonth){
                    currentDay = monthDay - (self.calendarObject.maxDayOfCurrentMonth + (self.calendarObject.maxDayOfLastMonth - self.calendarObject.firstDayOfLastMonth));
                    dayState = dayStateUnactive;
                    components.month++;
                }
            }
            components.day = currentDay;
            
            CGRect frame = CGRectMake(self.xPosition + weekDay * self.size,
                                      self.yPosition + week * self.size,
                                      self.size,
                                      self.size);
            LBCDayView *dayView = [[LBCDayView alloc] initWithComponent:components
                                                            andDayState:dayState
                                                               andFrame:frame];
            dayView.isLastDayInMonth = isLastDayInMonth;
            [tmpArray addObject:dayView];
            [self addSubview:dayView];
        }
    }
    self.dayArray = [NSArray arrayWithArray:tmpArray];
}



@end


