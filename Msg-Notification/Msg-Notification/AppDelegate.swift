//
//  AppDelegate.swift
//  Msg-Notification
//
//  Created by prologue on 2016. 8. 11..
//  Copyright © 2016년 SQLPRO. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        
        // 어떤 알림이 사용될 것이라는 환경 정보를 설정하고 이를 어플리케이션에 등록
        let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(setting)
        
        if let localNoti = launchOptions?[UIApplicationLaunchOptionsKey.localNotification] as? UILocalNotification {
            // 알림으로 인해 앱이 실행된 경우이다. 이 때에는 알림과 관련된 처리를 해 준다.
            print((localNoti.userInfo?["name"])!)
            
            // 원하는 화면으로 이동
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: "vc")
                
            application.keyWindow?.rootViewController = vc
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        if #available(iOS 11.0, *) {
            // 알림 설정 내용을 확인
            
            let setting = application.currentUserNotificationSettings
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }
            
            // 알림 콘텐츠 객체
            let nContent = UNMutableNotificationContent()
            
            nContent.badge = 1
            nContent.body = "어서어서 들어오세요!!"
            nContent.title = "로컬 알림 메세지"
            nContent.subtitle = "서브타이틀"
            nContent.sound = UNNotificationSound.default()
            
            // 알림 발송 조건 객체
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            // 알림 요청 객체
            let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
            
            // 노티피케이션 센터에 추가
            UNUserNotificationCenter.current().add(request)
        } else {
            // 알림 설정 내용을 확인
            let setting = UIApplication.shared.currentUserNotificationSettings
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }

            // 알림 메세지 준비
            let date = Date(timeIntervalSinceNow: 10)
            let noti = UILocalNotification()
            noti.fireDate = date
            noti.timeZone = TimeZone.autoupdatingCurrent
            noti.alertBody = "얼른 다시 접속하세요!!!"
            noti.alertAction = "학습하기"
            noti.applicationIconBadgeNumber = 1
            noti.soundName = UILocalNotificationDefaultSoundName
            noti.userInfo = ["name":"test"]
            
            // 알림 발송 (스케줄러에 등록)
            application.scheduleLocalNotification(noti)
            //application.presentLocalNotificationNow(noti) // 즉시 발송하고자 할 때
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print((notification.userInfo?["name"])!)
        
        if application.applicationState == UIApplicationState.active {
            // 앱이 활성화 된 상태일 때 실행할 로직
        } else if application.applicationState == .inactive {
            // 앱이 비활성화된 상태일 때 실행할 로직
        }
    }


}

