//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCDayView.h"
#import "LBCCalendarObject.h"

@implementation LBCDayView

- (id) initWithComponent:(NSDateComponents *)component
             andDayState:(DayState)state
                andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        self.dateComponents = component;
        NSString *labelText = [NSString stringWithFormat:@"%lu", (long)component.day];
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.text = labelText;
        [self addSubview:self.dayLabel];
        
        _dayState = dayStateUnselected;
        self.dayState = state;
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
    
    if (_dayState == dayStateUnactive)
        return;
    
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
                
            case dayStateBothSelected:{
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerBottomLeft)
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


