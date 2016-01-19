import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Deck.registerSubclass()
        Parse.setApplicationId("ssHRvlpmE88mvk8aojp0clPcw9mHnU0fSI5btZg6",
            clientKey: "biyIawqjmYrx1FFF71DRmJ2w2bmeoeH4DyzcOxfV")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
                        
        return true
    }
}
