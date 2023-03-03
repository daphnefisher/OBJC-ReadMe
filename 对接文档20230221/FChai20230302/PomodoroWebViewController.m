#import "PomodoroWebViewController.h"
#import <Masonry.h>
#import <AXWebViewController.h>

@interface PomodoroWebViewController ()

@property (nonatomic, strong) AXWebViewController *axWebVC;

@end

@implementation PomodoroWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.axWebVC = [[AXWebViewController alloc] initWithAddress:self.serverUrl];
    self.axWebVC.showsToolBar = NO;
    self.axWebVC.showsBackgroundLabel = NO;
    self.axWebVC.enabledWebViewUIDelegate = YES;
    [self.view addSubview:self.axWebVC.view];
    
    [self.axWebVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

@end
