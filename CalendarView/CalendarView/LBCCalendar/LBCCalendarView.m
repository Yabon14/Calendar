
//
//  TestView.m
//  CalendarView
//
//  Created by Yann BONAFONS on 10/08/2015.
//  Copyright (c) 2015 Yann BONAFONS. All rights reserved.
//

#import "LBCCalendarView.h"

@implementation LBCCalendarView



- (CGFloat) getNewFrameHeight {
    
//    CGFloat oldFooterHeight = self.footerHeight.constant;
  
    
    self.footerHeight.constant = 200.f;
    
//    CGFloat totalHeight = self.frame.size.height - oldFooterHeight + self.footerHeight.constant;
    return self.frame.size.height;
}




@end
