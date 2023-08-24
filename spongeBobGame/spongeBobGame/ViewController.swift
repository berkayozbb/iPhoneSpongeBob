//
//  ViewController.swift
//  spongeBobGame
//
//  Created by Berkay Özbaba on 19.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var highScoreLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var roundLabel: UILabel!
    
    @IBOutlet var startButtonOutlet: UIButton!
    
    var timer = Timer()
    var timerChangePositionImage = Timer()
    var timeCounter = 10
    var score = 0
    var highScore : Int = 0
    var round = 1
    var newHighScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isHidden = true
        highScore = UserDefaults.standard.integer(forKey: "score")
        highScoreLabel.text = "High Score: \(highScore)"
        roundLabel.isHidden = true
    }
    @objc func countScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    
    @IBAction func startButton(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterFunc), userInfo: nil, repeats: true)
        roundLabel.text = "Round: \(round)"
        imageView.isHidden = false
        roundLabel.isHidden = false
        startButtonOutlet.isHidden = true
    }
    
    @objc func counterFunc(){
//        var speedChangeImagePosition = 1.0
//        if(speedChangeImagePosition > 0.9){
//            speedChangeImagePosition = Double(1 / 0.9)
//        }
        timerChangePositionImage = Timer.scheduledTimer(timeInterval:TimeInterval(1.5) , target: self, selector:         #selector(changePosition), userInfo: nil, repeats: true)
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(countScore))
        imageView.addGestureRecognizer(gestureRecognizer)
        timeLabel.text = "Time: \(timeCounter)"
        timeCounter -= 1
        if(timeCounter < 0){
            if(score >= round*10){
                timeCounter = 10
                round += 1
                roundLabel.text = "Round: \(round)"
                imageView.isHidden = false
            }
            else{
                imageView.isHidden = true
                timer.invalidate()
                timeLabel.text = "Time's over"
                makeAlert(title: "Finito", message: "Time is over! Your score: \(score)")
                timeCounter = 10
                newHighScore = score
                if(newHighScore > highScore){
                    highScore = newHighScore
                    UserDefaults.standard.set(highScore, forKey: "score")
                    highScoreLabel.text = "High Score: \(highScore)"
                }
                score = 0
                scoreLabel.text = "Score: \(score)"
                round = 1
                roundLabel.isHidden = true
                startButtonOutlet.isHidden = false
            }
        }
    }
    
    @objc func changePosition(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width 
        let screenHeight = screenSize.height
        let randomPositionY = Int.random(in: 250...Int(screenHeight)-250)
        let randomPositionX = Int.random(in: 50...Int(screenWidth)-50)
        imageView.layer.position.y = CGFloat(randomPositionY)
        imageView.layer.position.x = CGFloat(randomPositionX)
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default) { UIAlertAction in
            print("button clicked")
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

