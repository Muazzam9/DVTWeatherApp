//
//  MainTabBarController.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view controllers
        let currentWeatherVC = WeatherViewController()
        currentWeatherVC.tabBarItem = UITabBarItem(title: "Current", image: UIImage(systemName: "cloud.sun"), tag: 0)

        let favoritesVC = WeatherViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 2)

        viewControllers = [currentWeatherVC, favoritesVC]
    }
}
