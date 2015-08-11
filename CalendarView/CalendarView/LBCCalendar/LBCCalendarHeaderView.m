//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarHeaderView.h"
#import "LBCCalendarObject.h"


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
        self.monthLabel.text = [calendarObject getCurrentMonthYearName];
        [self addSubview:self.monthLabel];
        
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        UIButton *leftArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
        [leftArrow setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
        leftArrow.tag = LEFT_ARROW_TAG;
        [leftArrow addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftArrow];
        
        UIButton *rightArrow = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - buttonSize, 0, buttonSize, buttonSize)];
        [rightArrow setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        rightArrow.tag = RIGHT_ARROW_TAG;
        [rightArrow addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightArrow];
#pragma clang diagnostic pop
        
        NSArray *dayArray = @[@"Lu", @"Ma", @"Me", @"Je", @"Ve", @"Sa", @"Di"];
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


