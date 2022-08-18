
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 15, *) {
                    let navigationBarAppearance = UINavigationBarAppearance()
                    navigationBarAppearance.configureWithOpaqueBackground()
                    navigationBarAppearance.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor.white
                    ]
                    navigationBarAppearance.backgroundColor = .systemGray
                    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                    UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    
                    let tabBarApperance = UITabBarAppearance()
                    tabBarApperance.configureWithOpaqueBackground()
                    tabBarApperance.backgroundColor = UIColor.blue
                    UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
                    UITabBar.appearance().standardAppearance = tabBarApperance
                }
        
        return true
    }

}

