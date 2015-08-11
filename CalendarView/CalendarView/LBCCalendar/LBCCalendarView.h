//
//  TestView.h
//  CalendarView
//
//  Created by Yann BONAFONS on 10/08/2015.
//  Copyright (c) 2015 Yann BONAFONS. All rights reserved.
//

#import <UIKit/UIKit.h>



@class LBCCalendarHeaderView, LBCCalendarMonthView, LBCCalendarFooterView;


@interface LBCCalendarView : UIView


@property (nonatomic, strong) IBOutlet LBCCalendarMonthView *monthView;
@property (nonatomic, strong) IBOutlet LBCCalendarHeaderView *headerView;
@property (nonatomic, strong) IBOutlet LBCCalendarFooterView *footerView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *footerHeight;
- (CGFloat) getNewFrameHeight;
@end
