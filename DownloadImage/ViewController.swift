//
//  ViewController.swift
//  DownloadImage
//
//  Created by Cntt35 on 7/5/17.
//  Copyright © 2017 Nhom5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgDownload1: UIImageView!
    @IBOutlet weak var imgDownload2: UIImageView!
    @IBOutlet weak var txtURL1: UITextField!
    @IBOutlet weak var txtURL2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnDownloadClick(_ sender: Any) {
        if txtURL1.text == "" || txtURL2.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please input URL", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            let url1 = txtURL1.text
            let url2 = txtURL2.text
            downloadImageWithURL(url1!, url2!)
        }
    }

    func downloadImageWithURL(_ url1: String, _ url2: String) {
        let imgURL1 = URL(string: url1)
        let imgURL2 = URL(string: url2)
        (URLSession(configuration: .default)).dataTask(with: imgURL1!, completionHandler: {(dataImage1, response, error) in
            if let data = dataImage1 {
                DispatchQueue.main.async() { () -> Void in
                    self.imgDownload1.image = UIImage(data: data)
                }
            }
        }).resume()
        (URLSession(configuration: .default)).dataTask(with: imgURL2!, completionHandler: {(dataImage2, response, error) in
            if let data = dataImage2 {
                OperationQueue.main.addOperation { () -> Void in
                    self.imgDownload2.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}

