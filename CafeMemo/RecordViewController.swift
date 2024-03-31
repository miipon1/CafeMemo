//
//  RecordViewController.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/04.
//
/*import Foundation
import UIKit
import RealmSwift

class RecordViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var tweetImageImageview: UIImageView!

    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.delegate = self
        
        // セグメントのラベsルを設定
        /*segmentedControl.setTitle("大人気", forSegmentAt: 0)
        segmentedControl.setTitle("人気", forSegmentAt: 1)
        segmentedControl.setTitle("普通", forSegmentAt: 2)
        segmentedControl.setTitle("穴場", forSegmentAt: 3)
        segmentedControl.setTitle("超穴場", forSegmentAt: 4)
        
        // イベントを追加
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        // デフォルトの選択インデックスを設定
        segmentedControl.selectedSegmentIndex = 0*/

    }

    @IBAction func saveTweet(_ sender: Any) {
        saveInputText()
        setAlert()
    }
    @IBAction func addImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        self.present(picker, animated: true)
    }

    func saveInputText() {
        guard let setTweetText = tweetTextField.text else {return}

        let tweet = Tweet()
        tweet.tweetText = setTweetText
        if let setTweetImage = tweetImageImageview.image{
            let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
            let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
            let tweetImageFileName = setTweetImage.saveImage(imageURL: imageURL, fileName: fileName)
            tweet.tweetImageName = tweetImageFileName
        }
        try! realm.write({
            realm.add(tweet)
        })
    }
    func setAlert() {
        let alert = UIAlertController(title: "保存", message: "保存されました", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    /*@IBOutlet weak var segmentedControl: UISegmentedControl!*/

        

        

      /*  @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
            print("Selected index: \(sender.selectedSegmentIndex)")
        }*/

}*/
/*extension AddTweetViewController: UITextFieldDelegate {
    //キーボードをreturnで閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tweetTextField.resignFirstResponder()
        return true
    }
    //キーボードを画面タップで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension AddTweetViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            tweetIamgeImageview.image = selectedImage
        }
        self.dismiss(animated: true)
    }
}
extension AddTweetViewController: UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}*/


/*import Foundation
import UIKit
import RealmSwift
import CoreLocation

class RecordViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var tweetImageImageview: UIImageView!
    @IBOutlet weak var tweetDatePicker: UIDatePicker!
    @IBOutlet weak var starRatingContainerView: UIView!
    /*@IBOutlet weak var pinView: UIImageView!*/
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageMenuButton: UIButton!
       
    let realm = try! Realm()

   var starRatingView: StarRatingView!
    var selectedImage: UIImage?

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.delegate = self // UITextFieldDelegateを設定
        setupSegmentedControl()
        locationManager.delegate = self
        
        /*
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()*/
      starRatingView = StarRatingView(frame: starRatingContainerView.bounds)
        starRatingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        starRatingView.rating = 0.0 // 初期の評価を設定
        starRatingContainerView.addSubview(starRatingView)
        setupImageMenuButton()
        
    }

    @IBAction func saveTweet(_ sender: Any) {
        saveInputText()
        setAlert()
        /*locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()*/
        locationManager.delegate = self
          locationManager.requestWhenInUseAuthorization()
          locationManager.startUpdatingLocation()
       
    }
    @IBAction func addImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self // UIImagePickerControllerDelegateとUINavigationControllerDelegateを設定
        present(picker, animated: true)
    }
    func setupImageMenuButton() {
           let imageMenu = UIMenu(title: "", children: [
               UIAction(image: UIImage(named: "pin1"), handler: { action in
                   self.selectedImage = UIImage(named: "pin1")
                   self.saveImageURL(imageName: "pin1") // 画像のアドレスを保存
               }),
               UIAction(image: UIImage(named: "pin2"), handler: { action in
                   self.selectedImage = UIImage(named: "pin2")
                   self.saveImageURL(imageName: "pin2") // 画像のアドレスを保存
               }),
               UIAction(image: UIImage(named: "pin3"), handler: { action in
                   self.selectedImage = UIImage(named: "pin3")
                   self.saveImageURL(imageName: "pin3") // 画像のアドレスを保存
               })
           ])
           imageMenuButton.menu = imageMenu // UIButtonにUIMenuを関連付ける
           imageMenuButton.showsMenuAsPrimaryAction = true
           imageMenuButton.setTitle("", for: .normal)
       }

       func saveImageURL(imageName: String) {
           // 画像のアドレスを保存
           let imageURLs = generateImageURLs(imageName: imageName)

           // 保存したいTweetオブジェクトにアクセスして、画像のアドレスを保存
           let tweet = Tweet() // ここで適切なTweetオブジェクトを生成する必要があります
           tweet.tweetImageURLs.append(objectsIn: imageURLs)
           // Realmに保存するなど、適切な処理を行う
       }

       func generateImageURLs(imageName: String) -> [String] {
           var imageURLs = [String]()
           for i in 1...3 {
               let imageURL = "素材/pin\(i).png" // 画像のディレクトリに合わせて適切なパスを設定
               imageURLs.append(imageURL)
           }
           return imageURLs
       }

       @IBAction func imageMenuButtonTapped(_ sender: UIButton) {
          /* // メニューが表示されるので、画像が選択された後の処理をここに記述する
           guard let selectedImage = self.selectedImage else {
                  return // 画像が選択されていない場合は何もしない
              }
              
              // 選択された画像を表示する
              tweetImageImageview.image = selectedImage*/
           
       }
    func selectImage(_ image: UIImage) {
        // 選択された画像を表示する
        tweetImageImageview.image = image
    }

    // UIMenu内のアクションで画像が選択された際に呼び出されるメソッド
    func didSelectImage(_ action: UIAction) {
        guard let selectedImage = action.image else { return }
        selectImage(selectedImage)
    }
    /*@IBAction func selectImage(_ sender: Any) {
        let imageMenu = UIMenu(title: "", children: [
            UIAction(image: UIImage(named: "coffeePin"), handler: { action in
                self.pinView.image = UIImage(named: "coffeePin")
            }),
            UIAction(image: UIImage(named: "macaronPin"), handler: { action in
                self.pinView.image = UIImage(named: "macaronPin")
            }),
        
            // 他の画像の選択肢も同様に追加
        ])
        
        let imageMenuButton = UIButton(type: .system)
        imageMenuButton.setTitle("Select Image", for: .normal)
        imageMenuButton.showsMenuAsPrimaryAction = true
        imageMenuButton.menu = imageMenu
        
        let imagePickerBarButton = UIBarButtonItem(customView: imageMenuButton)
        navigationItem.rightBarButtonItem = imagePickerBarButton
    }*/
    
    func saveInputText() {
        guard let tweetText = tweetTextField.text else { return }
        let tweet = Tweet()
        tweet.tweetText = tweetText
        print("店名: \(tweetText)")
        if let tweetImage = tweetImageImageview.image {
            let fileName = UUID().uuidString + ".jpeg"
            let imageURL = getImageURL(fileName: fileName)
            let tweetImageName = tweetImage.saveImage(imageURL: imageURL, fileName: fileName)
            tweet.tweetImageName = tweetImageName
        }
        
       /* if let selectedImage = pinView.image {
                let imageData = selectedImage.jpegData(compressionQuality: 0.8)
                tweet.tweetImageData = imageData
            }*/
        tweet.createdAt = tweetDatePicker.date
        let rating = starRatingView.rating
        tweet.rating = starRatingView.rating
        print("評価値: \(rating)")
        // StarRatingViewから評価を取得して保存
        let selectedRatingIndex = segmentedControl.selectedSegmentIndex
                tweet.tweetRating = selectedRatingIndex
        print("選択されたセグメントのインデックス: \(selectedRatingIndex)")
        
        if let currentLocation = locationManager.location {
                tweet.latitude = currentLocation.coordinate.latitude
                tweet.longitude = currentLocation.coordinate.longitude
            }

        
        try! realm.write({
            realm.add(tweet)
        })
    }
    /*func saveInputText() {
        guard let setTweetText = tweetTextField.text else {return}

        let tweet = Tweet()
        tweet.tweetText = setTweetText
        if let setTweetImage = tweetImageImageview.image{
            let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
            let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
            let tweetImageFileName = setTweetImage.saveImage(imageURL: imageURL, fileName: fileName)
            tweet.tweetImageName = tweetImageFileName
        }
        tweet.createdAt = tweetDatePicker.date
        try! realm.write({
            realm.add(tweet)
        })
    }*/
    func setAlert() {
        let alert = UIAlertController(title: "保存", message: "保存されました", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegateのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            tweetImageImageview.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setupSegmentedControl() {
            let items = ["超人気", "人気", "普通", "穴場", "超穴場"]
            segmentedControl.removeAllSegments()
            for (index, item) in items.enumerated() {
                segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
            }
        }
    
/*func saveLocationButtonPressed(_ sender: UIButton) {
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }*/

      /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           saveLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
           locationManager.stopUpdatingLocation()
           print("緯度: \(location.coordinate.latitude), 経度: \(location.coordinate.longitude)")
       }

       func saveLocation(latitude: Double, longitude: Double) {
           let tweet = Tweet()
           tweet.latitude = latitude
           tweet.longitude = longitude

           try! realm.write {
               realm.add(tweet)
           }
       }*/
   
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        print("緯度: \(location.coordinate.latitude), 経度: \(location.coordinate.longitude)")
    }

    func updateLocation(latitude: Double, longitude: Double) {
        guard let tweet = realm.objects(Tweet.self).last else {
            // データベースに保存された最後のTweetがない場合は処理を終了
            return
        }

        try! realm.write {
            // 既存のTweetオブジェクトの位置情報を更新
            tweet.latitude = latitude
            tweet.longitude = longitude
        }
    }*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        saveLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        print("緯度: \(location.coordinate.latitude), 経度: \(location.coordinate.longitude)")
    }

    func saveLocation(latitude: Double, longitude: Double) {
        if let tweet = realm.objects(Tweet.self).last {
            // データベースに保存された最後のTweetがある場合は位置情報を更新
            try! realm.write {
                tweet.latitude = latitude
                tweet.longitude = longitude
            }
        } else {
            // データベースに保存されたTweetがない場合は新しいTweetオブジェクトを作成して保存
            let newTweet = Tweet()
            newTweet.latitude = latitude
            newTweet.longitude = longitude
            try! realm.write {
                realm.add(newTweet)
            }
        }
    }



}*/
import Foundation
import UIKit
import RealmSwift
import CoreLocation

class RecordViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var tweetImageImageview: UIImageView!
    @IBOutlet weak var tweetDatePicker: UIDatePicker!
    @IBOutlet weak var starRatingContainerView: UIView!
    /*@IBOutlet weak var pinView: UIImageView!*/
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageMenuButton: UIButton!
       
    let realm = try! Realm()

   var starRatingView: StarRatingView!
    var selectedImage: UIImage?

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.delegate = self // UITextFieldDelegateを設定
        setupSegmentedControl()
        locationManager.delegate = self
        
        /*
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()*/
      starRatingView = StarRatingView(frame: starRatingContainerView.bounds)
        starRatingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        starRatingView.rating = 0.0 // 初期の評価を設定
        starRatingContainerView.addSubview(starRatingView)
        setupImageMenuButton()
        
    }

    @IBAction func saveTweet(_ sender: Any) {
        saveInputText()
        setAlert()
        /*locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()*/
        locationManager.delegate = self
          locationManager.requestWhenInUseAuthorization()
          locationManager.startUpdatingLocation()
       
    }
    @IBAction func addImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self // UIImagePickerControllerDelegateとUINavigationControllerDelegateを設定
        present(picker, animated: true)
    }
    func setupImageMenuButton() {
           let imageMenu = UIMenu(title: "", children: [
               UIAction(image: UIImage(named: "pin1"), handler: { action in
                   self.selectedImage = UIImage(named: "pin1")
                   self.saveImageURL(imageName: "pin1") // 画像のアドレスを保存
               }),
               UIAction(image: UIImage(named: "pin2"), handler: { action in
                   self.selectedImage = UIImage(named: "pin2")
                   self.saveImageURL(imageName: "pin2") // 画像のアドレスを保存
               }),
               UIAction(image: UIImage(named: "pin3"), handler: { action in
                   self.selectedImage = UIImage(named: "pin3")
                   self.saveImageURL(imageName: "pin3") // 画像のアドレスを保存
               })
           ])
           imageMenuButton.menu = imageMenu // UIButtonにUIMenuを関連付ける
           imageMenuButton.showsMenuAsPrimaryAction = true
           imageMenuButton.setTitle("", for: .normal)
       }

       func saveImageURL(imageName: String) {
           // 画像のアドレスを保存
           let imageURLs = generateImageURLs(imageName: imageName)

           // 保存したいTweetオブジェクトにアクセスして、画像のアドレスを保存
           let tweet = Tweet() // ここで適切なTweetオブジェクトを生成する必要があります
           tweet.tweetImageURLs.append(objectsIn: imageURLs)
           // Realmに保存するなど、適切な処理を行う
       }

       func generateImageURLs(imageName: String) -> [String] {
           var imageURLs = [String]()
           for i in 1...3 {
               let imageURL = "素材/pin\(i).png" // 画像のディレクトリに合わせて適切なパスを設定
               imageURLs.append(imageURL)
           }
           return imageURLs
       }

       @IBAction func imageMenuButtonTapped(_ sender: UIButton) {
          /* // メニューが表示されるので、画像が選択された後の処理をここに記述する
           guard let selectedImage = self.selectedImage else {
                  return // 画像が選択されていない場合は何もしない
              }
              
              // 選択された画像を表示する
              tweetImageImageview.image = selectedImage*/
           
       }
    func selectImage(_ image: UIImage) {
        // 選択された画像を表示する
        tweetImageImageview.image = image
    }

    // UIMenu内のアクションで画像が選択された際に呼び出されるメソッド
    func didSelectImage(_ action: UIAction) {
        guard let selectedImage = action.image else { return }
        selectImage(selectedImage)
    }
    /*@IBAction func selectImage(_ sender: Any) {
        let imageMenu = UIMenu(title: "", children: [
            UIAction(image: UIImage(named: "coffeePin"), handler: { action in
                self.pinView.image = UIImage(named: "coffeePin")
            }),
            UIAction(image: UIImage(named: "macaronPin"), handler: { action in
                self.pinView.image = UIImage(named: "macaronPin")
            }),
        
            // 他の画像の選択肢も同様に追加
        ])
        
        let imageMenuButton = UIButton(type: .system)
        imageMenuButton.setTitle("Select Image", for: .normal)
        imageMenuButton.showsMenuAsPrimaryAction = true
        imageMenuButton.menu = imageMenu
        
        let imagePickerBarButton = UIBarButtonItem(customView: imageMenuButton)
        navigationItem.rightBarButtonItem = imagePickerBarButton
    }*/
    
    func saveInputText() {
        guard let tweetText = tweetTextField.text else { return }
        let tweet = Tweet()
        tweet.tweetText = tweetText
        print("店名: \(tweetText)")
        if let tweetImage = tweetImageImageview.image {
            let fileName = UUID().uuidString + ".jpeg"
            let imageURL = getImageURL(fileName: fileName)
            let tweetImageName = tweetImage.saveImage(imageURL: imageURL, fileName: fileName)
            tweet.tweetImageName = tweetImageName
        }
        
       /* if let selectedImage = pinView.image {
                let imageData = selectedImage.jpegData(compressionQuality: 0.8)
                tweet.tweetImageData = imageData
            }*/
        tweet.createdAt = tweetDatePicker.date
        let rating = starRatingView.rating
        tweet.rating = starRatingView.rating
        print("評価値: \(rating)")
        // StarRatingViewから評価を取得して保存
        let selectedRatingIndex = segmentedControl.selectedSegmentIndex
                tweet.tweetRating = selectedRatingIndex
        print("選択されたセグメントのインデックス: \(selectedRatingIndex)")
        
        if let currentLocation = locationManager.location {
                tweet.latitude = currentLocation.coordinate.latitude
                tweet.longitude = currentLocation.coordinate.longitude
            }

        
        try! realm.write({
            realm.add(tweet)
        })
    }
    /*func saveInputText() {
        guard let setTweetText = tweetTextField.text else {return}

        let tweet = Tweet()
        tweet.tweetText = setTweetText
        if let setTweetImage = tweetImageImageview.image{
            let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
            let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
            let tweetImageFileName = setTweetImage.saveImage(imageURL: imageURL, fileName: fileName)
            tweet.tweetImageName = tweetImageFileName
        }
        tweet.createdAt = tweetDatePicker.date
        try! realm.write({
            realm.add(tweet)
        })
    }*/
    func setAlert() {
        let alert = UIAlertController(title: "保存", message: "保存されました", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegateのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            tweetImageImageview.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setupSegmentedControl() {
            let items = ["超人気", "人気", "普通", "穴場", "超穴場"]
            segmentedControl.removeAllSegments()
            for (index, item) in items.enumerated() {
                segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
            }
        }
    
/*func saveLocationButtonPressed(_ sender: UIButton) {
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }*/

      /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           saveLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
           locationManager.stopUpdatingLocation()
           print("緯度: \(location.coordinate.latitude), 経度: \(location.coordinate.longitude)")
       }

       func saveLocation(latitude: Double, longitude: Double) {
           let tweet = Tweet()
           tweet.latitude = latitude
           tweet.longitude = longitude

           try! realm.write {
               realm.add(tweet)
           }
       }*/
   
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        print("緯度: \(location.coordinate.latitude), 経度: \(location.coordinate.longitude)")
    }

    func updateLocation(latitude: Double, longitude: Double) {
        guard let tweet = realm.objects(Tweet.self).last else {
            // データベースに保存された最後のTweetがない場合は処理を終了
            return
        }

        try! realm.write {
            // 既存のTweetオブジェクトの位置情報を更新
            tweet.latitude = latitude
            tweet.longitude = longitude
        }
    }*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        saveLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        print("緯度: \(location.coordinate.latitude), 経度: \(location.coordinate.longitude)")
    }

    func saveLocation(latitude: Double, longitude: Double) {
        if let tweet = realm.objects(Tweet.self).last {
            // データベースに保存された最後のTweetがある場合は位置情報を更新
            try! realm.write {
                tweet.latitude = latitude
                tweet.longitude = longitude
            }
        } else {
            // データベースに保存されたTweetがない場合は新しいTweetオブジェクトを作成して保存
            let newTweet = Tweet()
            newTweet.latitude = latitude
            newTweet.longitude = longitude
            try! realm.write {
                realm.add(newTweet)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                tweetTextField.resignFirstResponder()
                return true
            }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }

}
