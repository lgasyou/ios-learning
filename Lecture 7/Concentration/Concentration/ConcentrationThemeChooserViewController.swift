//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by xenon on 2021/6/15.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    // 这种做法不能够适配多语言应用
    private let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒🏑",
        "Faces": "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉",
        "Animals": "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐽🐸",
    ]
    
    override func viewDidLoad() {
        print("CTCVC")
        print(navigationController?.viewControllers ?? "")
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
            print(navigationController?.viewControllers ?? "")
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                let cvc = segue.destination as? ConcentrationViewController
                cvc?.theme = theme
                lastSeguedToConcentrationViewController = cvc
            }
        }
    }

}
