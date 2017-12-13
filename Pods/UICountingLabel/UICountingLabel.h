#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    UILabelCountingMethodEaseInOut,
    UILabelCountingMethodEaseIn,
    UILabelCountingMethodEaseOut,
    UILabelCountingMethodLinear
} UILabelCountingMethod;

typedef NSString* (^UICountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^UICountingLabelAttributedFormatBlock)(CGFloat value);
typedef void(^completionBlock)();

@interface UICountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSString *positiveFormat;//fengefu
@property (nonatomic, assign) UILabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) UICountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) UICountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) completionBlock block;

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currentValue;

@end

