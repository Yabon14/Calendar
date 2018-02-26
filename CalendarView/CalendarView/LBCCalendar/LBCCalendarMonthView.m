//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarMonthView.h"
#import "LBCDayView.h"
#import "LBCCalendarObject.h"


@implementation LBCCalendarMonthView

- (void) refreshWithCalendarObject:(LBCCalendarObject *)calendarObject{
    
    if (!self.calendarObject)
        self.calendarObject = calendarObject;
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (int week = 0 ; week < MAX_WEEK_PER_MONTH; week++) {
        for (int weekDay = 0 ; weekDay < MAX_DAY_PER_WEEK; weekDay++) {
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setMonth:self.calendarObject.currentMonth];
            NSDate *dateForCurrentMonth = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:calendarObject.startDate options:0];
            NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:dateForCurrentMonth];

            components.weekday = weekDay == 0 ? weekDaySaturday : weekDay;
            
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
            
            LBCDayView *dayView = (LBCDayView *)[self viewWithTag:monthDay];
            if (dayView && [dayView isKindOfClass:[LBCDayView class]]){
                [dayView refreshWithComponent:components andDayState:dayState andDayFont:self.calendarObject.dayNumberFont];
                dayView.isLastDayInMonth = isLastDayInMonth;
                [tmpArray addObject:dayView];
            }
        }
    }
    self.dayArray = [NSArray arrayWithArray:tmpArray];
}



@end


