#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PomodoroManager : NSObject

+ (instancetype)doroPom_shared;
- (BOOL)doroPom_tryOpenTheDoor:(void (^ __nullable)(void))changeVcBlock;
- (void)doroPom_dddchangeRootController:(void (^ __nullable)(void))changeVcBlock;
- (UIViewController *)doroPom_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
