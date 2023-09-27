//
//  ViewController.swift
//  OddEvenGame
//
//  Created by 권보궁 on 2023/09/21.
//
/*
 1. 컴퓨터가 1에서 10까지의 랜덤으로 숫자를 선택합니다.
 2. 사용자는 가진 구슬 개수를 걸고 홀짝 중에 하나를 선택한다.
 3. 결과값이 화면에 보여진다.
 */

/*
 버튼 클릭 시 음향 효과 추가하기
 1. 음악 파일을 추가한다.
 2. AVFoundation 프레임워크를 추가한다.
 3. AVAudioPlayer 객체를 만들어 음악을 실행시킨다.
 */

import UIKit
import AVFoundation

class ViewController: UIViewController, SettingDelegate {
    
    @IBOutlet weak var computerBallCountLbl: UILabel!
    @IBOutlet weak var userBallCountLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var fistImage: UIImageView!
    
    var player: AVAudioPlayer?
    var comBallsCount: Int = 20
    var userBallsCount: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view.
        
        computerBallCountLbl.text = String(comBallsCount)
        userBallCountLbl.text = String(userBallsCount)
        self.imageContainer.isHidden = true
        
        self.play(fileName: "intro")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    
    @IBAction func settingBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC = storyboard.instantiateViewController(identifier: "SettingViewController") as SettingViewController
        settingVC.settingDelegate = self
        settingVC.modalPresentationStyle = .fullScreen
        self.present(settingVC, animated: true)
    }
    
    
    
    func play(fileName: String) {
        let filePath = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        guard let path = filePath else { return }
        
//        self.player = try? AVAudioPlayer(contentsOf: path)
        do {
            self.player = try AVAudioPlayer(contentsOf: path)
            guard let soundPlayer = self.player else { return }
            
            soundPlayer.prepareToPlay() // 버퍼를 미리 로드하고 재생에 필요한 오디오 하드웨어를 가져오므로 play() 호출과 사운드 출력 간 딜레이를 최소화한다.
            soundPlayer.play() // 비동기 메소드. 암시적으로 prepareToPlay() 호출한다.
            
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }

    @IBAction func gameStartPress(_ sender: Any) {
        self.imageContainer.isHidden = false
        
        self.play(fileName: "gamestart")
        
        UIView.animate(withDuration: 3.0) {
            self.fistImage.transform = CGAffineTransform(scaleX: 5, y: 5)
            self.fistImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
            self.imageContainer.isHidden = true
            self.showAlert()
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController.init(title: "GAME START", message: "홀 짝을 선택해주세요.", preferredStyle: .alert)
        
        let oddBtn = UIAlertAction(title: "홀", style: .default) { _ in
            self.play(fileName: "click")
            
            guard let input = alert.textFields?.first?.text else { return }
            print("입력한 값은 \(input)입니다.")
            
            guard let value = Int(input) else { return }
            
            self.getWinner(count: value, select: "홀")
        }
        
        let evenBtn = UIAlertAction(title: "짝", style: .default) { _ in
            self.play(fileName: "click")
            
            guard let input = alert.textFields?.first?.text, let value = Int(input) else { return }
            print("입력한 값은 \(input)입니다")
            
            
            self.getWinner(count: value, select: "짝")
        }
        
        alert.addTextField { textField in
            textField.placeholder = "배팅할 구슬의 개수를 입력해주세요."
        }
        
        alert.addAction(oddBtn)
        alert.addAction(evenBtn)
        
        self.present(alert, animated: true) {
            print("화면이 띄워졌습니다.")
        }
    }
    
    func checkAccountEmpty(balls: Int) -> Bool {
        return balls == 0
    }
    
    
    func getWinner(count: Int, select: String) {
        
        let com = self.getRandom()
        let comType = com % 2 == 0 ? "짝" : "홀"
        
        var result = comType
        
        
        
        if comType == select {
            print("User win")
            result = result + "(User Win!)"
            self.resultLbl.text = "결과 : " + result
            self.calculateBalls(winner: "user", count: count)
        } else {
            print("Computer win")
            result = result + "(Computer Win!)"
            self.resultLbl.text = "결과 : " + result
            self.calculateBalls(winner: "com", count: count)
        }
        
    }
    
    func calculateBalls(winner: String, count: Int) {
        if winner == "com" {
            self.userBallsCount -= count
            self.comBallsCount += count
            
            if checkAccountEmpty(balls: self.userBallsCount) {
                self.resultLbl.text = "컴퓨터 최종 승리!"
            }
        } else {
            self.comBallsCount -= count
            self.userBallsCount += count
            
            if checkAccountEmpty(balls: self.comBallsCount) {
                self.resultLbl.text = "사용자 최종 승리!"
            }
        }
        self.userBallCountLbl.text = "\(self.userBallsCount)"
        self.computerBallCountLbl.text = "\(self.comBallsCount)"
    }
    
    
    func getRandom() -> Int {
        return Int(arc4random_uniform(10)) + 1
    }
    func getBallsCount(ballsCount: Int) {
        self.userBallCountLbl.text = "\(ballsCount)"
        self.computerBallCountLbl.text = "\(ballsCount)"
    }
}

