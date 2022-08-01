//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius : CGFloat = 8.0
    }
    
    
    private let usernameField: UITextField = {
        //called ananymous closure?
        
        let field = UITextField()
        field.placeholder = "아이디"
        field.returnKeyType = .next
        field.leftViewMode = .always
        //left view is adding padding to the text
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        //called ananymous closure?
        
        let field = UITextField()
        field.placeholder = "이메일"
        field.returnKeyType = .next
        field.leftViewMode = .always
        //left view is adding padding to the text
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        //so that cannot see the actual text

        field.placeholder = "비밀번호"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        //left view is adding padding to the text
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        view.backgroundColor = .systemBackground
    

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 52)
    }
    
    @objc private func didTapRegisterButton(){
        //make keyboards go back in
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
      
        
        guard let email = emailField.text, !email.isEmpty,
          let password = passwordField.text, !password.isEmpty, password.count>=8,
            let username = usernameField.text, !username.isEmpty else {
             return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    //good to go
                    self.dismiss(animated: true, completion: nil)
                    let VC = LoginViewController()
                    self.present(VC,animated: true)
                }
                else {
                    //failed
                    let alert = UIAlertController(title: "가입 오류", message: "가입에 오류가 생겼습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
  
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "계정 생성하기"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension RegistrationViewController : UITextFieldDelegate {
    //can control by one delegate by asking which field it is.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else{
            didTapRegisterButton()
        }
        return true
    }
}
