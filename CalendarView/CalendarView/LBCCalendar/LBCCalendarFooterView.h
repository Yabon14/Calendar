//
//  LBCCalendarFooterView.h
//  CalendarView
//
//  Created by Yann BONAFONS on 11/08/2015.
//  Copyright (c) 2015 Yann BONAFONS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBCCalendarFooterCellView : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface LBCCalendarFooterView : UITableView
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *footerHeight;
@end
