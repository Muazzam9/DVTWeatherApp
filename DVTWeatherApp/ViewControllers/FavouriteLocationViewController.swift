//
//  FavouriteLocationViewController.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/21.
//

import UIKit
import SwiftUI

class FavouriteLocationViewController: UIViewController {

    var colorSchemeManager: ColorSchemeManager

    init(colorSchemeManager: ColorSchemeManager) {
        self.colorSchemeManager = colorSchemeManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let contentView = CitiesListView()
            .environmentObject(colorSchemeManager)
            .environment(DataStore(forPreviews: true))
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        view.addSubview(hostingController.view)

        // Ensure the hosting controller's view uses auto layout
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hostingController.didMove(toParent: self)
    }
}

