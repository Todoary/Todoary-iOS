//
//  SignUpViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    //MARK: - UIComponenets
    
    var email: String = ""
    var certificationCode : String = ""
    var passwd : String = ""
    var passwdCheck : String = ""
    var name : String = ""
    var nickname : String = ""
    
    var isValidEmail = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidCertiCode = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidPasswd = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidPasswdCheck = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidName = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidNickname = false{
        didSet{
            self.validateUserInput()
        }
    }
    
//    let navigationView = NavigationView().then{
//        $0.navigationTitle.text = "회원가입"
//    }
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
        $0.setPlaceholderColor()
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let idCertificationButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
        
        $0.addTarget(self, action: #selector(certificationBtnDidClicked(_:)), for: .touchUpInside)
    }
    
    let idCanUseLabel = UILabel().then{
        $0.font = UIFont.nbFont(type: .sub1)
        $0.isHidden = true
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
        
    }

    let certificationTextField = UITextField().then{
        $0.textColor = .headline
        $0.setPlaceholderColor()
        $0.font = UIFont.nbFont(type: .body2)
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
        $0.addTarget(self, action: #selector(certificationOKBtnDidClicked(_:)), for: .touchUpInside)
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "영문, 숫자 포함 8자리 이상"
        $0.setPlaceholderColor()
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body2)
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwInvalidLabel = UILabel().then{
        $0.text = "*영문, 숫자 포함 8자리 이상"
        $0.textColor = .problemRed
        $0.font = UIFont.nbFont(type: .sub1)
        $0.isHidden = true
    }

    let pwCertificationTextField = UITextField().then{
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.textColor = .headline
    }

    let pwCertificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let pwIncorrectLabel = UILabel().then{
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = .problemRed
        $0.font = UIFont.nbFont(type: .sub1)
        $0.isHidden = true
    }

    //name
    let nameTitle = UILabel().then{
        $0.text = "이름"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }

    let nameTextField = UITextField().then{
        $0.placeholder = "이름을 입력해주세요"
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.textColor = .headline
    }

    let nameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    //nickname
    let nickNameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }

    let nickNameTextField = UITextField().then{
        $0.placeholder = "Todoary에서 사용하실 닉네임을 알려주세요"
        $0.setPlaceholderColor()
        $0.font = UIFont.nbFont(type: .body2)
        $0.textColor = .headline
    }

    let nickNameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let nextButton = UIButton().then{
//        $0.isEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.addTarget(self, action: #selector(nextButtonDidClicked(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
        textFieldAddRecognizer()
    
    }

    func validateUserInput(){
        if isValidName
            && isValidPasswd
            && isValidNickname
            && isValidCertiCode
            && isValidPasswdCheck {
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
    
    func textFieldAddRecognizer(){
        
        let tfChangedArray = [idTextField, nameTextField,nickNameTextField,certificationTextField, pwCertificationTextField]
        
        tfChangedArray.forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        }
        
        pwTextField.addTarget(self, action: #selector(textFieldDidEditingEnd(_:)), for: .editingDidEnd)
    }
    
    @objc
    func textFieldDidEditingChanged(_ sender: UITextField){
        
        let text = sender.text ?? ""
        
        switch sender {
        case idTextField:
            isValidEmail = text.isValidEmail()
            email = text
            return
        case certificationTextField:
            isValidCertiCode = true
            return
        case pwCertificationTextField:
            let bool = (sender.text == passwd)
            isValidPasswdCheck = bool
            
            if (bool){
                pwIncorrectLabel.isHidden = true
            }else{
                pwIncorrectLabel.isHidden = false
            }
            return
        case nameTextField:
            isValidName = text.isValidName()
            name = text
            return
        case nickNameTextField:
            isValidNickname = text.isValidNickname()
            nickname = text
            return
        default:
            fatalError("Missing Textfield")
        }
    }
    
    @objc
    func textFieldDidEditingEnd(_ sender : UITextField){
        
        let text = sender.text ?? ""
        
        switch sender{
        case pwTextField:
            isValidPasswd = text.isValidPassword()
            if(!isValidPasswd){
                pwInvalidLabel.isHidden = false
            }
            passwd = text
            return
        default:
            fatalError("Missing Textfield")
        }
    }
    
    @objc
    func certificationBtnDidClicked(_ sender: UIButton){
        
        //이메일 중복 여부 확인
        idCanUseLabel.isHidden = false
        
        if(isValidEmail){
            
            /*
            if() 사용가능 이메일 점검 조건문 추가
             */
            idCanUseLabel.text = "*사용 가능한 이메일입니다."
            idCanUseLabel.textColor = .todoaryGrey
            
            //이메일 사용 가능한 경우, 메일 발송 팝업 띄우기
            let alert = UIAlertController(title: "인증코드가 메일로 발송되었습니다.", message: "", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.setTitle()
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
            /*
            else{
                idCanUseLabel.text = "*이미 사용중인 이메일입니다."
                idCanUseLabel.textColor = .problemRed
            }
             */
            
        }else{
            idCanUseLabel.text = "*이메일 형식이 올바르지 않습니다."
            idCanUseLabel.textColor = .problemRed
        }
            
    }
    
    @objc
    func certificationOKBtnDidClicked(_ sender: UIButton){
        
        let alertTitle : String!
        
        if isValidCertiCode{
            alertTitle = "인증이 완료되었습니다."
        }else{
            alertTitle = "인증코드가 일치하지 않습니다."
        }
        
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
            
    }
    
    @objc
    func nextButtonDidClicked(_ sender: UIButton){
        print("click")
        self.navigationController?.pushViewController(TestViewController(), animated: true)
    }
    
    

}
