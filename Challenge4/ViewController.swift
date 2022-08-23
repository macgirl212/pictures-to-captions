//
//  ViewController.swift
//  Challenge4
//
//  Created by Melody Davis on 8/20/22.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures = [Picture]()
    var newCaption = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addNewImage))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row].caption
        
        return cell
    }
    
    @objc func addNewImage() {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
            
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: {
            let ac = UIAlertController(title: "Enter caption", message: nil, preferredStyle: .alert)
            ac.addTextField()
            let submitCaption = UIAlertAction(title: "Enter", style: .default) { [weak self, weak ac] _ in
                self?.newCaption = ac?.textFields?[0].text ?? "New Picture"
            }
            ac.addAction(submitCaption)
            picker.present(ac, animated: true)
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
            
        let imageName = UUID().uuidString
            
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let newPicture = Picture(image: imagePath, caption: newCaption)
        pictures.append(newPicture)
        tableView.reloadData()
        newCaption = ""
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].image
            vc.selectedCaption = pictures[indexPath.row].caption
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

