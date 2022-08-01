//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import UIKit

class EditProfileViewController: UIViewController, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장하기", style: .done, target: self, action: #selector(didTapSave))
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancel))
        
        
    
        

        // Do any additional setup after loading the view.
    }
    
    private func createTableHeaderView() -> UIView {
        //shows the current profile pic
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/3).integral)
        
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x:(view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    
    //MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
    
    //MARK: - Action
    
    @objc private func didTapSave(){
        //save info into database
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "프로필 사진", message: "프로필 사진 변경하기", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "사진 쵤영하기", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "앨범에서 사진 선택하기", style: .default, handler: { _ in
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "취소하기", style: .default, handler: nil))
        
        //for ipad
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
        
    }


}
