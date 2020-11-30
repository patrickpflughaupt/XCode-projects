//
//  ViewController.swift
//  Hot
//
//  Created by Patrick Pflughaupt on 22/11/2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Variables
    var seconds = 30
    var timer = Timer()
    var audioPlayerEnd = AVAudioPlayer()
    var audioPlayerTicking = AVAudioPlayer()
    var popup = UILabel()
    var array = ["European Countries", "Asian Countries", "Cold Countries", "Hot Countries", "World Capitals", "UK Cities", "US States",
                 "World Politicans", "World Political Parties",
                 "Disney Movies", "Hollywood Actors", "Hollywood Actresses", "Action Movies",  "Movie Genres", "Music Genres", "Royal Titles", "Award Shows",
                 "Music Bands", "Female Singers", "Male Singers", "Composers", "Film Directors",
                 "Types of Fruit", "Types of Vegetables", "What You Eat for Breakfast", "What You Eat for Dinner", "Seasonings and Sauces", "Junk Food", "Items That Are Frozen", "Ice Cream Flavours",
                 "Fast Food Restaurants",
                 "Subjects in School", "Universities", "Holidays in a Year", "Types of Jobs",
                 "Pet Animals", "Animals in the Zoo", "Animals in the Ocean",
                 "Types of Sports", "Members in the Family",
                 "Name of TV Series", "TV Channels", "Movie Characters",
                 "Types of Cocktails", "Types of Beverages",
                 "Airline Names", "Type of Transportations", "Human Anatomy",
                 "Currencies", "Emotions", "Positions in the Company", "Elements in the Periodic Table", "Book Genres", "Units", "Things You Bring on Holidays", "Things Found on a Map", "Things You Hang on the Wall", "Sounds of Things", "School Supplies", "Things That Jiggle", "Reasons a Child is Grounded", "Things You Find in a Forest", "Things You Encounter on Your Way to Work", "Things You Do After You Wake Up", "Toppings on Pizza", "Types of Drugs", "Things You Did Today", "Things That Cost a Lot", "Things That You Lose", "Things That Burn", "Natural Disasters", "Musical Instruments", "Musical Names", "Street Names",
                 "Animal Actions", "Actions in the House", "Name of Songs",
                 "Colours", "Things That Use Batteries", "Things That Are Alive", "Things That Are Green", "Things That Use Electricity", "Things That Fly", "Things You Can See From the Airplane Window", "Things That You Wear on Your Head", "Things That Float", "Things with Wheels", "Things in Space", "Things You Plug in", "Things Made of Glass", "Things Made of Wood", "Things That You Can Turn on and off", "Things with Buttons", "Things in the Kitchen", "Things in the Bathroom", "Things in the Bedroom", "Things in the Living Room", "Things in the Garden", "Things a Baby Has", "Things in a Shopping Mall", "Things That Grow", "Things at the Beach", "Ways to Cook Food", "Places to Spend Money", "Things That are Round", "Things That are Square", "Things at Christmas", "Sounds of Animals",
                 "Clothing Brands", "Clothing Items", "Car Manufacturers", "Company Names", "Phone Brands"]
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var rulesOutlet: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        // slider of time in seconds
        seconds = Int(sender.value)
        label.text = String(seconds) + " secs"
    }
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: UIButton) {
        // start button
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        
        sliderOutlet.isHidden = true
        startOutlet.isHidden = true
        rulesOutlet.isHidden = true
        label.isHidden = true
        skipOutlet.isHidden = false
        stopOutlet.isHidden = false

        showText()
        
        imageView.isHidden = false
    }
    
    @IBOutlet weak var skipOutlet: UIButton!
    @IBAction func skip(_ sender: UIButton) {
        // skip button
        showText()
    }
    
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stop(_ sender: UIButton) {
        // stop button
        timer.invalidate()
        seconds = 30
        sliderOutlet.setValue(30, animated: true)
        label.isHidden = false
        skipOutlet.isHidden = true
        stopOutlet.isHidden = true
        question.isHidden = true
        label.text = "30 secs"
        audioPlayerTicking.stop()
        
        sliderOutlet.isHidden = false
        startOutlet.isHidden = false
        rulesOutlet.isHidden = false
        imageView.isHidden = true
    }
    
    // Functions
    @objc func showText() {
        // display random element of text array in question label
        question.isHidden = false
        question.text = array.randomElement()
        
        question.lineBreakMode = NSLineBreakMode.byWordWrapping
        question.numberOfLines = 0
    }
    
    @objc func counter() {
        seconds -= 1
        audioPlayerTicking.play()
        
        if (seconds == 0) {
            timer.invalidate()
            audioPlayerTicking.stop()
            
            audioPlayerEnd.play()
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(stopAfter4seconds), userInfo: nil, repeats: false)
            
            question.isHidden = true
            skipOutlet.isHidden = true
            stopOutlet.isHidden = true
            imageView.isHidden = true
            showAlert()
        }
    }
    
    @objc func stopAfter4seconds() {
        // stop boom.mp3 after 4 seconds and restart game
        audioPlayerEnd.stop()
        sliderOutlet.isHidden = false
        startOutlet.isHidden = false
        rulesOutlet.isHidden = false
        
        seconds = 30
        label.text = String(seconds) + " secs"
        label.isHidden = false
        sliderOutlet.setValue(30, animated: true)
    }
    
    @objc func showAlert() {
        // customise your view
        popup.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        popup.text = "YOU LOSE :("
        popup.center = self.view.center
        self.popup.font = UIFont(name: "Chalkboard SE", size: 60)
        popup.textAlignment = .center
        popup.textColor = UIColor.red

        // show on screen
        self.view.addSubview(popup)
        popup.lineBreakMode = NSLineBreakMode.byWordWrapping
        popup.numberOfLines = 0

        // set the timer
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)
    }

    @objc func dismissAlert() {
        popup.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        question.isHidden = true
        skipOutlet.isHidden = true
        stopOutlet.isHidden = true
        rulesOutlet.isHidden = false
        imageView.image = UIImage(named: "Potato_question")
        imageView.isHidden = true
        
        do {
            let audioPathEnd = Bundle.main.path(forResource: "boom", ofType: ".mp3")
            try audioPlayerEnd = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPathEnd!))
            
            let audioPathTicking = Bundle.main.path(forResource: "ticking", ofType: ".mp3")
            try audioPlayerTicking = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPathTicking!))
        }
        catch {
            print("Unable to play audio")
        }
    }
}
