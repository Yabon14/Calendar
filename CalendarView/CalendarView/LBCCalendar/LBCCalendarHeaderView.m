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

- (void) refreshWithCalendarObject:(LBCCalendarObject *)calendarObject{

    self.monthLabel.backgroundColor = [UIColor clearColor];
    self.monthLabel.text = [calendarObject getCurrentMonthYearName];
        
    self.leftButton.tag = LEFT_ARROW_TAG;
    self.rightButton.tag = RIGHT_ARROW_TAG;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.leftButton addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop

    
    NSArray *dayArray = @[@"Sa", @"Di", @"Lu", @"Ma", @"Me", @"Je", @"Ve"];
    NSArray *dayLabelArray = @[self.dayLabel1, self.dayLabel2, self.dayLabel3, self.dayLabel4, self.dayLabel5, self.dayLabel6, self.dayLabel7];

    CGFloat fontSize = 200;
    for (UILabel *dayLabel in dayLabelArray) {
        dayLabel.backgroundColor = [UIColor clearColor];
//        dayLabel.numberOfLines = 1;
        dayLabel.textAlignment = NSTextAlignmentCenter;
//        dayLabel.minimumScaleFactor = 0.5f;
//        dayLabel.font = [UIFont systemFontOfSize:fontSize];
        [dayLabel setAdjustsFontSizeToFitWidth:YES];
        dayLabel.text = [dayArray objectAtIndex:[dayLabelArray indexOfObject:dayLabel]];
        [self setMaximumFontFrom:300 inLabel:dayLabel withMinimumScaleFactor:2.0f];
        NSLog(@"dayLabel.font.pointSize: %lu", (long)dayLabel.font.pointSize);
//        fontSize = fontSize > dayLabel.font.pointSize ? dayLabel.font.pointSize : fontSize;
    }
//    for (UILabel *dayLabel in dayLabelArray) {
//        dayLabel.font = [UIFont systemFontOfSize:fontSize];
//    }
    
    self.backgroundColor = [UIColor clearColor];
}



- (void) setMaximumFontFrom:(CGFloat)fontSize inLabel:(UILabel *)label withMinimumScaleFactor:(CGFloat)scaleFactor{

    CGRect frame = label.frame;
    
    CGRect newFrame;
    do{
        label.font = [UIFont systemFontOfSize:fontSize];
        [label sizeToFit];
        newFrame = label.frame;
        fontSize--;
    } while (newFrame.size.width > frame.size.width || newFrame.size.height > frame.size.height);
    
    fontSize *= scaleFactor;
    label.font = [UIFont systemFontOfSize:fontSize];
}


@end


