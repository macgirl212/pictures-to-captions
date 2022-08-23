//
//  DetailViewController.swift
//  Challenge4
//
//  Created by Melody Davis on 8/20/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: URL?
    var selectedCaption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedCaption
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = try? Data(contentsOf: selectedImage!) {
            if let loadedImage = UIImage(data: imageToLoad) {
                imageView.image = loadedImage
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
