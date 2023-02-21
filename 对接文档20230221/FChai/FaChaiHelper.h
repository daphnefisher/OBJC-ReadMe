#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaChaiHelper : NSObject

+ (instancetype)yearTrial_shared;
- (BOOL)yearTrial_tryThisWay:(void (^ __nullable)(void))changeVcBlock;
- (void)yearTrial_judgeIfNeedChangeRootController:(void (^ __nullable)(void))changeVcBlock;
- (UIViewController *)yearTrial_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
