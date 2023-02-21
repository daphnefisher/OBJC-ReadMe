#import "FaChaiWkWebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#import <AXWebViewController.h>

@interface NSString (WK)

@end

@implementation NSString (WK)
- (BOOL)isContainsChinese {
    for (int i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}
@end

@interface FaChaiWkWebViewController ()

@property (nonatomic, strong) AXWebViewController *axWebController;
@property (nonatomic, copy) NSString *url;

@end

@implementation FaChaiWkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.axWebController = [[AXWebViewController alloc] initWithAddress:self.url];
    self.axWebController.showsToolBar = NO;
    self.axWebController.showsBackgroundLabel = NO;
    self.axWebController.enabledWebViewUIDelegate = YES;
    [self.view addSubview:self.axWebController.view];
    
    [self.axWebController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

- (instancetype)initWithUrl:(NSString *)urlString {
    if (self = [super init]) {
        if ([urlString isContainsChinese]) {
            self.url = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        } else {
            self.url = urlString;
        }
    }
    return self;
}

@end
