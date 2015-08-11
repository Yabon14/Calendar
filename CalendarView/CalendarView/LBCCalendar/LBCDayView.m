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
        self.dayLabel.backgroundColor = [UIColor clearColor];
        self.dayLabel.text = labelText;

        self.dayLabel.textColor = C8;
        self.dayLabel.highlightedTextColor = C6;
        
        [self addSubview:self.dayLabel];
        self.backgroundColor = [UIColor clearColor];
        
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
                state = dayStateSelected;
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
                
            case dayStateBothSelected:{
                maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                 byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(radiusSize, radiusSize)];
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
        self.dayLabel.highlighted = YES;
    }
    
}


- (NSDate *)dateForDayView{
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:self.dateComponents];
    return date;
}

@end


