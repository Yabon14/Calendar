//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarHeaderView.h"
#import "LBCCalendarObject.h"
#import "LBCFont.h"

@implementation LBCCalendarHeaderView

- (void) refreshWithCalendarObject:(LBCCalendarObject *)calendarObject{

    self.monthLabel.backgroundColor = [UIColor clearColor];
    self.monthLabel.text = [calendarObject getCurrentMonthYearName];
    self.monthLabel.font = F7;
        
    self.leftButton.tag = LEFT_ARROW_TAG;
    self.rightButton.tag = RIGHT_ARROW_TAG;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.leftButton addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop

    
    NSArray *dayArray = @[NSLocalizedString(@"Lu", nil),
                          NSLocalizedString(@"Ma", nil),
                          NSLocalizedString(@"Me", nil),
                          NSLocalizedString(@"Je", nil),
                          NSLocalizedString(@"Ve", nil),
                          NSLocalizedString(@"Sa", nil),
                          NSLocalizedString(@"Di", nil)];
    NSArray *dayLabelArray = @[self.dayLabel1, self.dayLabel2, self.dayLabel3, self.dayLabel4, self.dayLabel5, self.dayLabel6, self.dayLabel7];

    for (UILabel *dayLabel in dayLabelArray) {
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.text = [dayArray objectAtIndex:[dayLabelArray indexOfObject:dayLabel]];
        dayLabel.font = F17;
    }
}



//- (void) setMaximumFontFrom:(CGFloat)fontSize inLabel:(UILabel *)label withMinimumScaleFactor:(CGFloat)scaleFactor{
//
//    CGRect frame = label.frame;
//    
//    CGRect newFrame;
//    do{
//        label.font = [UIFont systemFontOfSize:fontSize];
//        [label sizeToFit];
//        newFrame = label.frame;
//        fontSize--;
//    } while (newFrame.size.width > frame.size.width || newFrame.size.height > frame.size.height);
//    
//    fontSize *= scaleFactor;
//    label.font = [UIFont systemFontOfSize:fontSize];
//}


@end


