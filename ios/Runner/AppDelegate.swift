import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate{
    
    private let keyboardChannelName = "keyboard_channel"
    private var keyboardChannel: FlutterMethodChannel?
    
    func didInitializeImplicitFlutterEngine(_ engineBridge: any FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
        keyboardChannel = FlutterMethodChannel(name: keyboardChannelName, binaryMessenger: engineBridge.applicationRegistrar.messenger())
        setupKeyboardObservers()
    }
  
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return super.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }

    @objc
    private func keyboardWillChangeFrame(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frameEnd = userInfo[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? CGRect
        else {
            return
        }
        

        let screenHeight = UIScreen.main.bounds.height
        let keyboardHeight = max(0, screenHeight - frameEnd.origin.y)

        keyboardChannel?.invokeMethod(
            "keyboardHeight",
            arguments: Int(keyboardHeight)
        )

        keyboardChannel?.invokeMethod("keyboardAnimationStart", arguments: nil)
    }

    @objc
    private func keyboardDidShow(_ notification: Notification) {
        keyboardChannel?.invokeMethod(
            "keyboardAnimationDone",
            arguments: true
        )
    }

    @objc
    private func keyboardDidHide(_ notification: Notification) {
        keyboardChannel?.invokeMethod(
            "keyboardAnimationDone",
            arguments: false
        )
    }
}
