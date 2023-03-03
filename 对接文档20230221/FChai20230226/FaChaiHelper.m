
#import "FaChaiHelper.h"
#import <SafariServices/SFSafariViewController.h>
#import "FaChaiWkWebViewController.h"

@implementation FaChaiHelper


static NSString *yearTrail_apiAddress = @"https://mockapi.eolink.com/vnYJDif92f20d6aa4eefececcd22316e95cd00824a0cbc0/getSchool?responseId=1337703";
static NSString *yearTrail_mLink = @"mLink";
static NSString *yearTrail_pStyle = @"pStyle";
static NSString *yearTrail_flag = @"flag";
static NSString *yearTrail_tColor = @"tColor";
static NSString *yearTrail_bColor = @"bColor";

static FaChaiHelper *instance = nil;

+ (instancetype)yearTrial_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (BOOL)yearTrial_tryThisWay:(void (^ __nullable)(void))changeVcBlock {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:yearTrail_flag]) {
        return YES;
    } else {
      [self yearTrial_judgeIfNeedChangeRootController:changeVcBlock];
      return NO;
    }
}

- (void)yearTrial_judgeIfNeedChangeRootController:(void (^ __nullable)(void))changeVcBlock {
    NSURL *url = [NSURL URLWithString:yearTrail_apiAddress];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 20.0;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@" %@%@", objc, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            if ([[objc valueForKey:@"code"] intValue] == 200) {
                NSDictionary *dict = [objc valueForKey:@"data"];
                
                NSInteger pStyle = [[dict valueForKey:@"pStyle"] intValue];
                NSString *fresh_mLink = [dict valueForKey:@"mLink"];
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSInteger temp_pStyle = [ud integerForKey:yearTrail_pStyle];
                NSString *temp_mLink = [ud stringForKey:yearTrail_mLink];
                
                if ([temp_mLink isEqualToString:fresh_mLink] && temp_pStyle == pStyle) {
                    return;
                } else {
                    [ud setValue:fresh_mLink forKey:yearTrail_mLink];
                    [ud setInteger:pStyle forKey:yearTrail_pStyle];
                    [ud setValue:[dict valueForKey:@"tColor"] forKey:yearTrail_tColor];
                    [ud setValue:[dict valueForKey:@"bColor"] forKey:yearTrail_bColor];
                    [ud setBool:YES forKey:yearTrail_flag];
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

- (UIViewController *)yearTrial_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger pStyle = [ud integerForKey:yearTrail_pStyle];
    NSString *mLink = [ud stringForKey:yearTrail_mLink];
    
    UIColor *tColor = [self yearTrial_getColor:[ud stringForKey:yearTrail_tColor]] ;
    application.windows.firstObject.backgroundColor = tColor;
    if (pStyle == 3)  {
        SFSafariViewController *safariBrowser = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:mLink]];
        return safariBrowser;
    } else {
        if (pStyle == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mLink] options:@{} completionHandler:nil];
        }
        FaChaiWkWebViewController *chaiVC = [[FaChaiWkWebViewController alloc] initWithUrl:mLink];
        chaiVC.view.backgroundColor = tColor;
        [chaiVC.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor = tColor;
        }];
        return chaiVC;
    }
}

-(UIColor *)yearTrial_getColor:(NSString *)hexColor {
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

@end
