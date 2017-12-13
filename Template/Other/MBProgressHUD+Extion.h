

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extion)
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+ (void)showImage:(NSString *)hudImageName title:(NSString *)title toView:(UIView *)view;
@end
