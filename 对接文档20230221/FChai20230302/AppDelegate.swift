
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        if PomodoroManager.doroPom_shared().doroPom_tryOpenTheDoor({[weak self] in
            self?.window?.rootViewController = PomodoroManager.doroPom_shared().doroPom_changeRootController(application, withOptions: launchOptions ?? [:])
        }) {
            self.window?.rootViewController = PomodoroManager.doroPom_shared().doroPom_changeRootController(application, withOptions: launchOptions ?? [:])
            PomodoroManager.doroPom_shared().doroPom_dddchangeRootController()
        } else {
            let vc = PomodoroSettingsVC()
            let navContoller = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navContoller
        }
        
        window?.makeKeyAndVisible()
        return true
    }


}

