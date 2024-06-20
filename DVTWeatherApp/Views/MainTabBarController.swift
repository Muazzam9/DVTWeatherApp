//
//  MainTabBarController.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import UIKit

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorSchemeManager = ColorSchemeManager()

        // Setup view controllers
        let currentWeatherVC = WeatherViewController(colorSchemeManager: colorSchemeManager)
        currentWeatherVC.tabBarItem = UITabBarItem(title: "Current", image: UIImage(systemName: "cloud.sun"), tag: 0)

        let favoritesVC = WeatherViewController(colorSchemeManager: colorSchemeManager)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)

        viewControllers = [currentWeatherVC, favoritesVC]
    }
}
