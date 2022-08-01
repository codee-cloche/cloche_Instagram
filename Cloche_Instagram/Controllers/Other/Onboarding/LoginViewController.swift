//
//  LoginViewController.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius : CGFloat = 8.0
    }
    
    
    private let usernameEmailField: UITextField = {
        //called ananymous closure?
        
        let field = UITextField()
        field.placeholder = "아이디나 이메일을 입력하세요."
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

        field.placeholder = "비밀번호를 입력하세요."
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let headerView : UIView = {
        let header = UIView()
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 240, height: 29)
        view.backgroundColor = .white
        let image0 = UIImage(named: "logos")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        header.clipsToBounds = true
        //let backgroundImageView = UIImageView(image: UIImage(named: "logos"))
        header.addSubview(view)
        return header
        
    }()
    
    private let footerView : UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 98, height: 43)
        view.backgroundColor = .systemBackground
        let image0 = UIImage(named: "Screen Shot 2022-07-03 at 12.55.png")?.cgImage

        let layer0 = CALayer()
        layer0.contents = image0
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        return view
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("새로 오셨나요? 가입하기", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set what happens when pressed buttons
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    
        
        //delegates for when the user taps the buttons
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //assign frames
        
        //since header is first
        //headerView.frame = CGRect(x: 25, y: 25, width: view.width/2, height: view.height/4.0)
        headerView.frame = CGRect(x: 75, y: 226, width: 240, height: 29)
        configureHeaderView()
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 30,
            width: view.width - 50,
            height: 52.0)
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        
    }
    
    private func configureHeaderView(){
        //the header view should have only one subview
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
    
        
        //add logo
        //let imageView = UIImageView(image: UIImage(named: "logos"))
        //headerView.addSubview(imageView)
        //imageView.contentMode = .scaleAspectFit
        //imageView.frame = CGRect (...)
        //to change the size of the picture --> change the frame width and height
    }
    
    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        view.addSubview(footerView)
    }
    
    //functions for when the buttons are tapped
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        //login functionality
        
        var username: String?
        var email: String?
        
        //check if using email or username
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            //assume email
            email = usernameEmail
        }else {
            //username
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    //login success
                    self.dismiss(animated: true, completion: nil)
                    let VC = HomeViewController()
                    self.present(VC, animated: true)
            }
                else {
                //alert view
                let alert = UIAlertController(title: "로그인 실패", message: "아이디나 비밀번호를 확인해주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "다시 시도하기", style: .cancel, handler: nil))
               self.present(alert, animated: true)
            }
        }
    }
    }
    
    @objc private func didTapTermButton(){
        //not used now.
    }
    
    @objc private func didTapPrivacyButton(){}
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
    
}
