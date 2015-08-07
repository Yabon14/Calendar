//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarObject.h"
#import "LBCDayView.h"
#import "LBCMonthView.h"
#import "LBCCalendarHeaderView.h"

@implementation LBCSelection

- (id) initWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
    self = [super init];
    if (self){
        self.startDate = startDate;
        self.endDate = endDate;
    }
    return self;
}

@end


@implementation LBCCalendarObject

- (id) init{
    self = [super init];
    if (self){
        self.currentMonth = 0;
    }
    return self;
}


- (void) addSelectionFromDate:(NSDate *)startDate toDate:(NSDate *)endDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:startDate];
    startDate = [calendar dateFromComponents:components];
    
    components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:endDate];
    endDate = [calendar dateFromComponents:components];
    
    
    for (LBCDayView *dayView in self.monthView.dayArray) {
//        NSLog(@"%lu, %lu", (long)dayView.dateComponents.month, (long)dayView.dateComponents.day);
        
        if (([[dayView dateForDayView] compare:startDate] == NSOrderedDescending && [[dayView dateForDayView] compare:endDate] == NSOrderedAscending)
            || [[dayView dateForDayView] compare:startDate] == NSOrderedSame
            || [[dayView dateForDayView] compare:endDate] == NSOrderedSame)
        {
            BOOL leftCurve = NO;
            BOOL rightCurve = NO;
            
            if (dayView.dateComponents.weekday == 6) {
                rightCurve = YES;
            }
            else if (dayView.dateComponents.weekday == 0) {
                leftCurve = YES;
            }
            if (dayView.dateComponents.day == 1) {
                leftCurve = YES;
            }
            if ([dayView isLastDayInMonth]) {
                rightCurve = YES;
            }
            if ([[dayView dateForDayView] compare:startDate] == NSOrderedSame){
                leftCurve = YES;
            }
            if ([[dayView dateForDayView] compare:endDate] == NSOrderedSame){
                rightCurve = YES;
            }
            
            if (leftCurve && !rightCurve){
                dayView.dayState = dayStateFirstSelected;
            }
            else if (!leftCurve && rightCurve){
                dayView.dayState = dayStateLastSelected;
            }
            else if (leftCurve && rightCurve){
                dayView.dayState = dayStateBothSelected;
            }
            else{
                dayView.dayState = dayStateSelected;
            }
        }
    }
}


- (void) configureCalendar{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:self.currentMonth];
    NSDate *dateForCurrentMonth = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    NSRange rng = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateForCurrentMonth];
    self.maxDayOfCurrentMonth = rng.length;
    
    [dateComponents setMonth:self.currentMonth - 1];
    NSDate *dateForPreviousMonth = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    rng = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateForPreviousMonth];
    self.maxDayOfLastMonth = rng.length;
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateForCurrentMonth];
    [components setDay:1];
    
    NSDate *firstDayToShow = [calendar dateFromComponents:components];
    NSDateComponents *newComponents = [calendar components: NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:firstDayToShow];
    while (newComponents.weekday != 2) {
        NSDateComponents *comps = [NSDateComponents new];
        comps.day   = -1;
        firstDayToShow = [calendar dateByAddingComponents:comps toDate:firstDayToShow options:0];
        newComponents = [[NSCalendar currentCalendar] components: NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:firstDayToShow];
    }
    self.firstDayOfLastMonth = newComponents.day;
    self.firstDayOfLastMonth = self.firstDayOfLastMonth == 1 ? self.maxDayOfLastMonth + 1 : self.firstDayOfLastMonth;
}



- (NSString *)getCurrentMonthName{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:self.currentMonth];
    NSDate *dateForCurrentMonth = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:dateForCurrentMonth];
    return stringFromDate;
}




-(UIView *) buildCalendarViewInFrame:(CGRect) frame{

    [self configureCalendar];
    
    CGFloat width = frame.size.width / MAX_DAY_PER_WEEK;
    CGFloat height = frame.size.height / MAX_WEEK_PER_MONTH;
    CGFloat size = height < width ? height : width;

    UIView *calendarView = [[UIView alloc] initWithFrame:frame];

    self.monthView = [[LBCMonthView alloc] initWithCalendarObject:self
                                                         andFrame:CGRectMake(0,
                                                                    size,
                                                                    frame.size.width,
                                                                    frame.size.height - size)];
    [self.monthView refreshView];
    [calendarView addSubview:self.monthView];
    
    self.headerView = [[LBCCalendarHeaderView alloc] initWithFrame:CGRectMake(0,
                                                                              self.monthView.frame.origin.y + self.monthView.yPosition - size,
                                                                              frame.size.width,
                                                                              size)
                                                 andCalendarObject:self];
    [calendarView addSubview:self.headerView];
    
    
    return calendarView;
}


- (void) addSelectionArray:(NSArray *)selectionArray{
    self.selectionArray = selectionArray;
    [self addSelectionForCurrentMonth];
}


- (void) addSelectionForCurrentMonth{
    if (!self.selectionArray)
        return;
        
    for (LBCSelection *selection in self.selectionArray) {
        [self addSelectionFromDate:selection.startDate toDate:selection.endDate];
    }
}


- (void) buttonPressed:(id)sender{
    UIButton *b = (UIButton *)sender;
    if (b.tag == RIGHT_ARROW_TAG){
        self.currentMonth++;
    }
    else if (b.tag == LEFT_ARROW_TAG){
        self.currentMonth--;
    }
    
    [self configureCalendar];
    [self.monthView refreshView];
    [self addSelectionForCurrentMonth];
    self.headerView.monthLabel.text = [self getCurrentMonthName];
}


@end






