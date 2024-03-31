//
//  DetailViewController.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/10.
//

/*import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetDatePicker: UIDatePicker!
    @IBOutlet weak var starRatingContainerView: UIView!
    @IBOutlet weak var starRatingView: StarRatingView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    /*var tweets: [Tweet]!*/
    var tweets: [Tweet] = []
    var tweetNumber: Int = 0
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTweetData()
    }
    @IBAction func addImage(_ sender: Any) {
        
    }
    @IBAction func saveTweet(_ sender: Any) {
    }
    /* func setTweetData(){
        tweets = Array(realm.objects(Tweet.self)).reversed()
        tweetTextField.text = tweets[tweetNumber].tweetText
        if let tweetImageName = tweets[tweetNumber].tweetImageName{
            let tweetImageURL = tweetImageName.convertStringToURL()
            tweetImageView.image = tweetImageURL.getimageformURL()
        }
        if let createdAt = tweets[tweetNumber].createdAt {
                tweetDatePicker.date = createdAt
            }
        if let starRatingContainerView = starRatingContainerView {
            for subview in starRatingContainerView.subviews {
                if let starRatingView = subview as? StarRatingView {
                    let rating = tweets[tweetNumber].rating
                    starRatingView.rating = rating
                    break
                }
            }
        }
        /*for subview in starRatingContainerView.subviews {
                if let starRatingView = subview as? StarRatingView {
                    let rating = tweets[tweetNumber].rating
                    starRatingView.rating = rating
                    break
                }
            }*/
        /*let rating = tweets[tweetNumber].rating
            starRatingView.rating = rating*/
        
        let selectedSegmentIndex = tweets[tweetNumber].tweetRating
        let selectedItemData = segmentedControl.titleForSegment(at: selectedSegmentIndex)
    }*/
    func setTweetData() {
            tweets = Array(realm.objects(Tweet.self)).reversed()
            // tweetNumberが範囲内にあるか確認
            guard tweetNumber >= 0 && tweetNumber < tweets.count else {
                // 範囲外の場合は何もしないか、適切な処理を記述する
                return
            }

            // tweetNumberが範囲内の場合、正しいアイテムを取得して表示する
            let tweet = tweets[tweetNumber]
            tweetTextField.text = tweet.tweetText

            if let tweetImageName = tweet.tweetImageName {
                let tweetImageURL = tweetImageName.convertStringToURL()
                tweetImageView.image = tweetImageURL.getimageformURL()
            }
        

            if let createdAt = tweet.createdAt {
                tweetDatePicker.date = createdAt
            }

            if let starRatingContainerView = starRatingContainerView {
                for subview in starRatingContainerView.subviews {
                    if let starRatingView = subview as? StarRatingView {
                        let rating = tweet.rating
                        starRatingView.rating = rating
                        break
                    }
                }
            }

            /*let selectedSegmentIndex = tweet.tweetRating
            let selectedItemData = segmentedControl.titleForSegment(at: selectedSegmentIndex)*/
        let selectedSegmentIndex = tweet.tweetRating
            segmentedControl.selectedSegmentIndex = selectedSegmentIndex
    }
        
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}*/

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetDatePicker: UIDatePicker!
    @IBOutlet weak var starRatingContainerView: UIView!
    @IBOutlet weak var starRatingView: StarRatingView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    /*var tweets: [Tweet]!*/
    var tweets: [Tweet] = []
    var tweetNumber: Int = 0
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTweetData()
    }
    @IBAction func addImage(_ sender: Any) {
        
    }
    @IBAction func saveTweet(_ sender: Any) {
    }
    /* func setTweetData(){
        tweets = Array(realm.objects(Tweet.self)).reversed()
        tweetTextField.text = tweets[tweetNumber].tweetText
        if let tweetImageName = tweets[tweetNumber].tweetImageName{
            let tweetImageURL = tweetImageName.convertStringToURL()
            tweetImageView.image = tweetImageURL.getimageformURL()
        }
        if let createdAt = tweets[tweetNumber].createdAt {
                tweetDatePicker.date = createdAt
            }
        if let starRatingContainerView = starRatingContainerView {
            for subview in starRatingContainerView.subviews {
                if let starRatingView = subview as? StarRatingView {
                    let rating = tweets[tweetNumber].rating
                    starRatingView.rating = rating
                    break
                }
            }
        }
        /*for subview in starRatingContainerView.subviews {
                if let starRatingView = subview as? StarRatingView {
                    let rating = tweets[tweetNumber].rating
                    starRatingView.rating = rating
                    break
                }
            }*/
        /*let rating = tweets[tweetNumber].rating
            starRatingView.rating = rating*/
        
        let selectedSegmentIndex = tweets[tweetNumber].tweetRating
        let selectedItemData = segmentedControl.titleForSegment(at: selectedSegmentIndex)
    }*/
    func setTweetData() {
            tweets = Array(realm.objects(Tweet.self)).reversed()
            // tweetNumberが範囲内にあるか確認
            guard tweetNumber >= 0 && tweetNumber < tweets.count else {
                // 範囲外の場合は何もしないか、適切な処理を記述する
                return
            }

            // tweetNumberが範囲内の場合、正しいアイテムを取得して表示する
            let tweet = tweets[tweetNumber]
            tweetTextField.text = tweet.tweetText

            if let tweetImageName = tweet.tweetImageName {
                let tweetImageURL = tweetImageName.convertStringToURL()
                tweetImageView.image = tweetImageURL.getimageformURL()
            }
        

            if let createdAt = tweet.createdAt {
                tweetDatePicker.date = createdAt
            }
            starRatingView.rating = tweet.rating
            /*if let starRatingContainerView = starRatingContainerView {
                for subview in starRatingContainerView.subviews {
                    if let starRatingView = subview as? StarRatingView {
                        let rating = tweet.rating
                        starRatingView.rating = rating
                        break
                    }
                }
            }*/

            /*let selectedSegmentIndex = tweet.tweetRating
            let selectedItemData = segmentedControl.titleForSegment(at: selectedSegmentIndex)*/
        let selectedSegmentIndex = tweet.tweetRating
            segmentedControl.selectedSegmentIndex = selectedSegmentIndex
    }
        
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}

