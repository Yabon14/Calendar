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


@property (nonatomic, weak) IBOutlet LBCCalendarMonthView *monthView;
@property (nonatomic, weak) IBOutlet LBCCalendarHeaderView *headerView;
@property (nonatomic, weak) IBOutlet LBCCalendarFooterView *footerView;

@end
