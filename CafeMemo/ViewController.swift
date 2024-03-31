//
//  ViewController.swift
//  CafeMemo
//
//  Created by misaki on 2024/02/26.
//

/*import UIKit
import RealmSwift

class ViewController: UIViewController {
        let realm = try! Realm()
        var tweets = [Tweet]()
        var selectedNumber: Int!
        @IBOutlet weak var tweetTableView: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            tweetTableView.dataSource = self
            tweetTableView.delegate = self
            tweetTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        }
        override func viewWillAppear(_ animated: Bool) {
            gettweet()
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailView" {
                let vc = segue.destination as! DetailViewController
                vc.tweetNumber = selectedNumber
            }
        }

        func gettweet() {
            tweets = Array(realm.objects(Tweet.self)).reversed()
            tweetTableView.reloadData()
        }
    }*/
   /* extension ViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
            let tweet: Tweet = tweets[indexPath.row]
            cell.setTweet(tweetText: tweet.tweetText, tweetImageFileName: tweet.tweetImageName)
            return cell
        }


    }
    extension ViewController : UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 250
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedNumber = indexPath.row
            performSegue(withIdentifier: "toDetailView", sender: nil)
        }
    }*/
        
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }*/


import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate/*,
                      TweetTableViewCellDelegate*/ {
    /*func minusButtonTapped(in cell: TweetTableViewCell) {
        <#code#>
    }*/
    
  

    
    
    let realm = try! Realm()
    var tweets = [Tweet]()
    var selectedNumber: Int!
    
    @IBOutlet weak var tweetTableView: UITableView!
    /*@IBOutlet weak var editButton: UIButton!*/

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gettweet()
        tweetTableView.reloadData()
    }
    
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let vc = segue.destination as! DetailViewController
            vc.tweetNumber = selectedNumber
            
        }
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let selectedIndexPath = tweetTableView.indexPathForSelectedRow {
                let vc = segue.destination as! DetailViewController
                vc.tweets = tweets // ViewControllerからtweets配列を受け取る
                vc.tweetNumber = selectedIndexPath.row // 選択されたセルのインデックスを渡す
            }
        }
    }


    func gettweet() {
        tweets = Array(realm.objects(Tweet.self)).reversed()
        tweetTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
   /* func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        // セルにデータを設定する処理を記述する必要があります
        // 例: cell.textLabel?.text = tweet.title
        cell.setTweet(tweetText: tweet.text, tweetImageFileName: tweet.imageFileName)
        return cell
    }*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]

        // セルにデータを設定する
        cell.tweetTextLabel.text = tweet.tweetText
        // イメージの設定
        if let imageName = tweet.tweetImageName {
            let imageURL = getImageURL(fileName: imageName)
            cell.tweetImageView.image = UIImage(contentsOfFile: imageURL.path)
        } else {
            cell.tweetImageView.image = nil
        }
        cell.ratingLabel.text = "評価" + String(tweet.rating)
        
        /*cell.ratingLabel.text = tweet.rating*/
        /*cell.delegate = self*/
        /*cell.deleteButtonAction = {[weak self] in self?.deleteButtonTapped(cell: cell)}*/
        return cell
    }

    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNumber = indexPath.row
        performSegue(withIdentifier: "toDetailView", sender: self)
    }
   
    
    /*func didTapMinusButton(in cell: TweetTableViewCell) {
            guard let indexPath = tweetTableView.indexPath(for: cell) else {
                return
            }
            tweets.remove(at: indexPath.row)
            tweetTableView.deleteRows(at: [indexPath], with: .fade)
        }

        @IBAction func editButtonTapped(_ sender: UIButton) {
            tweetTableView.isEditing = !tweetTableView.isEditing
            let title = tweetTableView.isEditing ? "Done" : "Edit"
            editButton.setTitle(title, for: .normal)
        }*/
    
   /* func didTapMinusButton(in cell: TweetTableViewCell) {
           if let indexPath = tweetTableView.indexPath(for: cell) {
               tweets.remove(at: indexPath.row)
               tweetTableView.deleteRows(at: [indexPath], with: .automatic)
           }
       }*/
    /*func deleteItem(at indexPath: IndexPath){
        try! realm.write{
            realm.delete(tweets[indexPath.row])
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func deleteButtonTapped(cell: TweetTableViewCell) {
        guard let indexPath = tweetTableView.indexPath(for: cell) else {
            return
        }
        deleteItem(at: indexPath)
    }*/
    }


/*extension ViewController {
    func minusButtonTapped(in cell: TweetTableViewCell) {
        // ここに削除ボタンがタップされたときの処理を書く
        guard let indexPath = tweetTableView.indexPath(for: cell) else {
            return
        }
        tweets.remove(at: indexPath.row)
        tweetTableView.deleteRows(at: [indexPath], with: .fade)
    }
}*/
