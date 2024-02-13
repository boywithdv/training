import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private func clearAllNotifications(_ application: UIApplication) {
    application.applicationIconBadgeNumber = 0
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
}
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  //ローカル通知権限
  if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
  }
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let notificationsChannel = FlutterMethodChannel(name: "com.example/notifications", binaryMessenger: controller.binaryMessenger)
    
    notificationsChannel.setMethodCallHandler { call, result in
        guard call.method == "clearAllNotifications" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.clearAllNotifications(application)
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
