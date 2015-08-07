//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarViewController.h"

#define MAX_WEEK_PER_MONTH          6
#define MAX_DAY_PER_WEEK            7

#define SELECTED_HEIGHT_COEFF       0.8f

#define HEADER_HEIGHT_COEFF         0.8f

#define RADIUS_CELL                 25

@implementation LBCDayView

- (id) initWithComponent:(NSDateComponents *)component
             andDayState:(DayState)dayState
                andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        self.dateComponents = component;
        NSString *labelText = [NSString stringWithFormat:@"%lu", (long)component.day];
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.text = labelText;
        [self addSubview:self.dayLabel];
        self.dayState = dayState;
    }
    return self;
}


- (void) setDayState:(DayState)state{
    
    UIBezierPath *maskPath = nil;
    
    CGFloat height = self.frame.size.height * SELECTED_HEIGHT_COEFF;
    CGRect frame = CGRectMake(0,
                              self.frame.size.height * 0.5f - height * 0.5f,
                              self.frame.size.width,
                              height);

    if (self.selectedView){
        [self.selectedView removeFromSuperview];
        self.selectedView = nil;
    }
    
    switch (state) {
            case dayStateUnactive:
                self.dayLabel.textColor = [UIColor clearColor];
                break;

            case dayStateUnselected:
            break;
            
            case dayStateFirstSelected:{
                frame.size.width += 5.f;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(RADIUS_CELL, RADIUS_CELL)];
                break;
            }
            
            case dayStateSelected:{
                self.selectedView = [[UIView alloc] initWithFrame:frame];
                self.selectedView.backgroundColor = [UIColor orangeColor];
                [self addSubview:self.selectedView];
                [self sendSubviewToBack:self.selectedView];
                break;
            }
            
            case dayStateLastSelected:{
                frame.size.width += 5.f;
                frame.origin.x -= 5.f;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(RADIUS_CELL, RADIUS_CELL)];
                break;
            }
            
            default:
                break;
    }
    
    _dayState = state;
    
    if (maskPath){
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        self.backgroundColor = [UIColor orangeColor];
    }
    
}


- (NSDate *)dateForDayView{
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:self.dateComponents];
    return date;
}

@end



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



#define DAY_TAG_VIEW        1002
- (void) refreshView{
    
    for (UIView* v in self.subviews){
        if (v.tag == DAY_TAG_VIEW)
            [v removeFromSuperview];
    }
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    for (int week = 0 ; week < MAX_WEEK_PER_MONTH; week++) {
        for (int weekDay = 0 ; weekDay < MAX_DAY_PER_WEEK; weekDay++) {
            NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:[NSDate date]];
            components.weekday = weekDay;
            NSInteger monthDay = week * MAX_DAY_PER_WEEK + weekDay;
            
            NSInteger currentDay;
            DayState dayState = dayStateUnselected;
            
            if (self.calendarObject.firstDayOfLastMonth + monthDay <= self.calendarObject.maxDayOfLastMonth){
                components.month--;
                currentDay = self.calendarObject.firstDayOfLastMonth + monthDay;
                dayState = dayStateUnactive;
            }
            else {
                currentDay = monthDay - (self.calendarObject.maxDayOfLastMonth - self.calendarObject.firstDayOfLastMonth);
                if (currentDay > self.calendarObject.maxDayOfCurrentMonth){
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
            dayView.tag = DAY_TAG_VIEW;
            [tmpArray addObject:dayView];
            [self addSubview:dayView];
        }
    }
    self.dayArray = [NSArray arrayWithArray:tmpArray];
}



@end



#define TITLE_HEADER_COEFF          2/3
#define LEFT_ARROW_TAG              1000
#define RIGHT_ARROW_TAG             1001
#define FIRST_DAY_FIX_VALUE         9999

@implementation LBCCalendarHeaderView

- (id)initWithFrame:(CGRect)frame andCalendarObject:(LBCCalendarObject *)calendarObject{
    self = [super initWithFrame:frame];
    if (self){
        CGFloat buttonSize = frame.size.height * TITLE_HEADER_COEFF;
        self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonSize,
                                                                        0,
                                                                        frame.size.width - 2 * buttonSize,
                                                                        buttonSize)];
        self.monthLabel.textAlignment = NSTextAlignmentCenter;
        self.monthLabel.text = [calendarObject getCurrentMonthName];
        [self addSubview:self.monthLabel];
        
        
        UIButton *leftArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
        leftArrow.backgroundColor = [UIColor redColor];
        leftArrow.tag = LEFT_ARROW_TAG;
        [leftArrow addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftArrow];
        
        UIButton *rightArrow = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - buttonSize, 0, buttonSize, buttonSize)];
        rightArrow.backgroundColor = [UIColor redColor];
        rightArrow.tag = RIGHT_ARROW_TAG;
        [rightArrow addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightArrow];
        
        NSArray *dayArray = @[@"Lun", @"Mar", @"Mer", @"Jeu", @"Ven", @"Sam", @"Dim"];
        CGFloat dayXPos = 0.f;
        CGFloat dayWidth = frame.size.width / MAX_DAY_PER_WEEK;
        CGFloat dayHeight = frame.size.height - buttonSize;
        for (int day = 0 ; day < MAX_DAY_PER_WEEK ; day ++) {
            UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(dayXPos, buttonSize, dayWidth, dayHeight)];
            dayLabel.text = [dayArray objectAtIndex:day];
            dayLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:dayLabel];
            dayXPos += dayWidth;
        }
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
        NSLog(@"%lu, %lu", (long)dayView.dateComponents.month, (long)dayView.dateComponents.day);
        if ([[dayView dateForDayView] compare:startDate] == NSOrderedSame){
            dayView.dayState = dayStateFirstSelected;
        }
        else if ([[dayView dateForDayView] compare:startDate] == NSOrderedDescending && [[dayView dateForDayView] compare:endDate] == NSOrderedAscending){
            if (dayView.dateComponents.weekday == 6) {
                dayView.dayState = dayStateLastSelected;
            }
            else if (dayView.dateComponents.weekday == 0) {
                dayView.dayState = dayStateFirstSelected;
            }
            else{
                dayView.dayState = dayStateSelected;
            }
        }
        else if ([[dayView dateForDayView] compare:endDate] == NSOrderedSame){
            dayView.dayState = dayStateLastSelected;
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
    
    self.monthView = [[LBCMonthView alloc] initWithCalendarObject:self
                                                         andFrame:CGRectMake(0,
                                                                    size,
                                                                    frame.size.width,
                                                                    frame.size.height - size)];
    [self.monthView refreshView];
    
    self.headerView = [[LBCCalendarHeaderView alloc] initWithFrame:CGRectMake(0,
                                                                              self.monthView.yPosition - size,
                                                                              frame.size.width,
                                                                              size)
                                                 andCalendarObject:self];
    [self.monthView addSubview:self.headerView];
    
    
    return self.monthView;
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
    self.headerView.monthLabel.text = [self getCurrentMonthName];
}


@end







@implementation LBCCalendarViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.calendarObject = [[LBCCalendarObject alloc] init];
    UIView *calView = [self.calendarObject buildCalendarViewInFrame:self.view.frame];
    [self.view addSubview:calView];
    
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addSelection:)];
    [self.view addGestureRecognizer:tg];
}


- (void) addSelection:(id)sender{
    
    NSDate *startDate = [NSDate date];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:7];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    
    [self.calendarObject addSelectionFromDate:startDate toDate:endDate];
}

@end

