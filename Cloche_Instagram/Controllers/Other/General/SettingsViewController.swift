//
//  SettingsViewController.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import UIKit
import SafariServices

struct SettingCellModel {
    //design, model for the cell
    let title : String
    let handler : (() -> Void)
    
}
///View Controller to Show user the settings.
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    //2d array of cells
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    private func configureModels(){
        data.append([
            SettingCellModel(title: "프로필 수정하기") { [weak self ] in
                //weak self --> preventing memory leak
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "친구 초대하기") { [weak self ] in
               //weak self --> preventing memory leak
                self?.didTapInviteFriends()
            }
            
        ])
        
        
        data.append([
            SettingCellModel(title: "도움말") { [weak self ] in
                //weak self --> preventing memory leak
                self?.openURL(type: .help)
            },
            SettingCellModel(title: "피드백 남기기") { [weak self ] in
                //weak self --> preventing memory leak
                self?.openURL(type: .terms)
            }
        ])
        
        data.append([
            SettingCellModel(title: "로그아웃하기") { [weak self ] in
                //weak self --> preventing memory leak
                self?.didTapLogOut()
            }
        ])
        
    }
    
    private func didTapLogOut(){
        //action sheet to log out
        
        let actionSheet = UIAlertController(title: "로그아웃", message: "로그아웃을 하시겠습니까?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: {success in
                DispatchQueue.main.async {
                    if success {
                        //present log in screen
                        let loginVC = LoginViewController()
                        //full screen so the user cannot swipe away
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            //make sure that when login again, it's the homeViewController
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                        
                    } else {
                        //error occurred
                        fatalError("로그아웃이 실패하였습니다.")
                    }
                }
            })
        }))
        
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
        
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "프로필 수정하기"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends(){
        //use contacts or show a sharesheet
        
    }
    
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://www.notion.so/CLOCHE-4b2194f4631e41269cfc8b23d982c100"
        case .privacy: urlString = "https://www.notion.so/CLOCHE-4b2194f4631e41269cfc8b23d982c100"
        case .help: urlString = "https://www.notion.so/CLOCHE-4b2194f4631e41269cfc8b23d982c100"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
        //handle cell selection.
    }
}
