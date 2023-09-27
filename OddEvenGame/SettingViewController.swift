//
//  SettingViewController.swift
//  OddEvenGame
//
//  Created by 권보궁 on 2023/09/27.
//

import UIKit

protocol SettingDelegate {
    func getBallsCount(ballsCount: Int)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var ballsCountTf: UITextField!
    
    var settingDelegate: SettingDelegate?
    var defaultBallsCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func completeBtnPressed(_ sender: UIButton) {
        print("-------1")
        guard let balls = self.ballsCountTf.text, let b = Int(balls) else {
            print("invalid value")
            self.settingDelegate?.getBallsCount(ballsCount: self.defaultBallsCount)
            self.dismiss(animated: true)
            return
        }
        print("-------2")
        self.settingDelegate?.getBallsCount(ballsCount: b)
        print("-------3")
        self.dismiss(animated: true)
        print("-------4")
    }

}
