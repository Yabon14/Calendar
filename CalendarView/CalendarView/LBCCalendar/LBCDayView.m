//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCDayView.h"
#import "LBCCalendarObject.h"
#import "LBCFont.h"
#import "LBCColor.h"

@implementation LBCDayView

- (void) refreshWithComponent:(NSDateComponents *)component
                  andDayState:(DayState)state
                   andDayFont:(UIFont *)dayFont{
    
    self.dateComponents = component;
    NSString *labelText = [NSString stringWithFormat:@"%lu", (long)component.day];
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor clearColor];
    self.text = labelText;
    self.textColor = C8;
    self.font = dayFont;

    
    _dayState = dayStateUnselected;
    self.dayState = state;
    
    if (self.containerView)
    {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
}


- (void) setDayState:(DayState)state{
    
    UIBezierPath *maskPath = nil;
    
    CGFloat height = self.frame.size.height * SELECTED_HEIGHT_COEFF;
    CGRect frame = CGRectMake(0,
                              self.frame.size.height * 0.5f - height * 0.5f,
                              self.frame.size.width,
                              height);

    switch (_dayState) {
        case dayStateUnactive:
            return;
        case dayStateUnselected:
            break;
        case dayStateFirstSelected:
            if (state == dayStateLastSelected){
                state = dayStateSelected;
            }
            else if (state == dayStateBothSelected){
                state = dayStateFirstSelected;
            }
            break;
        case dayStateLastSelected:
            if (state == dayStateFirstSelected){
                //state = dayStateSelected;
                state = dayStateBothSelected;
            }
            else if (state == dayStateBothSelected){
                state = dayStateLastSelected;
            }
            break;
        case dayStateSelected:
            if (state == dayStateFirstSelected
                || state == dayStateLastSelected
                || state == dayStateBothSelected){
                state = dayStateSelected;
            }
            break;
            
        default:
            break;
    }

    CGFloat radiusSize = RADIUS_CELL_COEFF * self.frame.size.height;
    BOOL needAddMask = YES;
    switch (state) {
            case dayStateUnactive:
                self.textColor = [UIColor clearColor];
                needAddMask = NO;
                break;

            case dayStateUnselected:
                needAddMask = NO;
            break;
            
            case dayStateFirstSelected:{
                frame.size.width += 5.f;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(radiusSize, radiusSize)];
                break;
            }
            
            case dayStateSelected:{
                frame.size.width += 10.f;
                frame.origin.x -= 5.f;
                maskPath = [UIBezierPath bezierPathWithRect:frame];
                break;
            }
            
            case dayStateLastSelected:{
                frame.size.width += 5.f;
                frame.origin.x -= 5.f;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(radiusSize, radiusSize)];
                break;
            }
                
            case dayStateOneDaySelected:{
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(radiusSize, radiusSize)];
                break;
            }
            
            case dayStateBothSelected:
                break;
            
            default:
            needAddMask = NO;
                break;
    }
    _dayState = state;

    
    if (needAddMask){
        
        if (self.dayState == dayStateBothSelected)
        {
            
            //Add left curve layer
            CGRect frameMaskLeftCurve = frame;
            frameMaskLeftCurve.size.width += 5.f;
            UIBezierPath *firstMaskPath = [UIBezierPath bezierPathWithRoundedRect:frameMaskLeftCurve
                                                                byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                                      cornerRadii:CGSizeMake(radiusSize, radiusSize)];
            
            CAShapeLayer *maskLayerLeftCurve = [[CAShapeLayer alloc] init];
            maskLayerLeftCurve.frame = self.bounds;
            maskLayerLeftCurve.path = firstMaskPath.CGPath;
            
            self.layer.mask = maskLayerLeftCurve;
            
            //Add right curve layer
            CGRect frameMaskRightCurve = frame;
            frameMaskRightCurve.size.width += 5.f;
            frameMaskRightCurve.origin.x -= 5.f;
            UIBezierPath *lastMaskPath = [UIBezierPath bezierPathWithRoundedRect:frameMaskRightCurve
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                   cornerRadii:CGSizeMake(radiusSize, radiusSize)];
            
            CAShapeLayer *maskLayerRightCurve = [[CAShapeLayer alloc] init];
            maskLayerRightCurve.frame = self.bounds;
            maskLayerRightCurve.path = lastMaskPath.CGPath;
            
            self.containerView = [[UIView alloc] initWithFrame:self.frame];
            self.containerView.layer.mask = maskLayerRightCurve;
            self.containerView.layer.mask.opacity = DAY_VIEW_SELECTED_COLOR_OPACITY;
            self.containerView.backgroundColor = C2;
            [self.superview addSubview:self.containerView];
            [self.superview sendSubviewToBack:self.containerView];
        }
        else
        {
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            self.layer.mask = maskLayer;

        }
        
        self.layer.mask.opacity = DAY_VIEW_SELECTED_COLOR_OPACITY;
        self.textColor = C6;
        self.backgroundColor = C2;

    }
    
}


- (NSDate *)dateForDayView{
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:self.dateComponents];
    return date;
}

@end


