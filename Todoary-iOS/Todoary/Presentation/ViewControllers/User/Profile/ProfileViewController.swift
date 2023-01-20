//
//  ProfileViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/11.
//

import UIKit
import SnapKit
import Then
import Photos

class ProfileViewController : BaseViewController {
    
//MARK: - Properties
    
    let imagePickerController = UIImagePickerController()
    
    var isPhoto = false
    
    let mainView = ProfileView()
    

    
//MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        requestGetProfile()
        
        //닉네임 textfield 10자 글자수제한 + observer
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(textFieldDidChange(_:)),
                                            name: UITextField.textDidChangeNotification,
                                            object: nil)
        
        //한줄소개 textview 30자 글자수제한 + observer
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(textViewDidChange(_:)),
                                            name: UITextView.textDidChangeNotification,
                                            object: nil)
    }
    
    override func style(){
        super.style()
        navigationTitle.text = "계정"
    }
    
    override func layout(){
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        
        mainView.imagePicker.addTarget(self, action: #selector(imagePickerDidTab), for: .touchUpInside)
        mainView.confirmBtn.addTarget(self, action: #selector(confirmBtnDidTab), for: .touchUpInside)
        
    }
    
    
    
//MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    //사진변경 버튼 누르기 -> 현재사진삭제 or 갤러리선택
    @objc func imagePickerDidTab(_ sender: Any) {
        
        //사진 접근권한 메시지 보여주기 (처음에만)
        PhotoAuth()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "현재 사진 삭제", style: .default, handler:
                                            {(UIAlertAction) in
            self.mainView.profileImage.image = UIImage(named: "profile")
            self.requestDeleteProfileImage()
        })
        
        let albumSelectAction = UIAlertAction(title: "갤러리에서 선택", style: .default, handler: { [self](UIAlertAction) in
            
            //접근권한 있는지 없는지 체크
            isPhoto = PhotoAuth()
            
            if self.isPhoto { //권한 있는 경우 사진 고르기
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            } else {//권한 없는 경우 팝업 띄우기
                    self.AuthSettingOpen(AuthString: "사진")
            }

        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(removeAction)
        alert.addAction(albumSelectAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func confirmBtnDidTab() {
        let profileRequestModel = ProfileRequestModel(nickname: mainView.nickNameTf.text, introduce: mainView.introduceTf.text)
        requestModifyProfile(parameter: profileRequestModel)
        requestModifyProfileImage(parameter: mainView.profileImage.image!)
    }
    
//MARK: - Keyboard
    
    @objc func textFieldDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            switch textField {
            case mainView.nickNameTf:
                if let text = mainView.nickNameTf.text {
                    
                    if mainView.nickNameTf.text!.count < 11 {
                        mainView.nickNameCount.text = "\(text.count)/10"
                    }
                    
                    if text.count >= 10 {
                        //주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
                        let maxIndex = text.index(text.startIndex, offsetBy: 10)
                        //문자열 자르기
                        let newString = text.substring(to: maxIndex)
                        mainView.nickNameTf.text = newString
                    }
                }
            default:
                return
            }
        }
    }
    
    @objc func textViewDidChange(_ notification: Notification) {
        if let textView = notification.object as? UITextView {
            switch textView {
            case mainView.introduceTf:
                if let text = mainView.introduceTf.text {
                    
                    if mainView.introduceTf.text!.count < 31 {
                        mainView.introduceCount.text = "\(text.count)/30"
                    }
                    
                    if text.count >= 30 {
                        //주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
                        let maxIndex = text.index(text.startIndex, offsetBy: 30)
                        //문자열 자르기
                        let newString = text.substring(to: maxIndex)
                        mainView.introduceTf.text = newString
                    }
                }
            default:
                return
            }
        }
    }
    
}

//MARK: - API
extension ProfileViewController {
    // 프로필 조회
    func requestGetProfile(){
        ProfileService.shared.getProfile(){ [self] result in
            switch result{
            case .success(let data):
                if let profileData = data as? ProfileResultModel{
                    print("[requestGetProfile] success in Account")
                    mainView.nickNameTf.text = profileData.nickname
                    mainView.introduceTf.text = profileData.introduce
                    mainView.nickNameCount.text = "\(profileData.nickname!.count)/10"
                    if ((profileData.introduce != nil)){
                        mainView.introduceCount.text = "\(profileData.introduce!.count)/30"
                    }
                    if (profileData.profileImgUrl != nil){
                        let url = URL(string: profileData.profileImgUrl!)
                        mainView.profileImage.load(url: url!)
                    }
                }
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestModifyProfile(parameter: ProfileRequestModel){
        ProfileService.shared.modifyProfile(request: parameter){ result in
            switch result{
            case .success:
                print("[requestModifyProfile] success")
                self.mainView.nickNameNotice.isHidden = true
                self.navigationController?.popViewController(animated: true)
                break
            case .invalidSuccess(let code):
                switch code{
                case 2032:
                    print("중복된 닉네임입니다")
                    self.mainView.nickNameNotice.isHidden = false
                    break
                default:
                    break
                }
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestModifyProfileImage(parameter: UIImage){
        ProfileService.shared.modifyProfileImage(image: parameter){ [self] result in
            switch result{
            case .success:
                print("[requestModifyProfileImage] success")
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestDeleteProfileImage(){
        ProfileService.shared.deleteProfileImage(){ [self] result in
            switch result{
            case .success:
                print("[requestDeleteProfileImage] success")
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
}

//MARK: - Image권한
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.profileImage.contentMode = .scaleAspectFill
            mainView.profileImage.image = pickedImage //4
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func PhotoAuth() -> Bool {
        // 포토 라이브러리 접근 권한
        var isAuth = false
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true // 모든 권한 허용
        case .denied:
            return false // 권한 거부
        case .limited:
            return true // 사진 선택적으로 허용
        case .notDetermined: // 아직 결정된 것이 없는 경우
            PHPhotoLibrary.requestAuthorization { (state) in
                if state == .authorized {
                    isAuth = true
                }
            }
            return isAuth
        case .restricted:
            return false // 권한 x
        default: return false
        }
    }
    
    func AuthSettingOpen(AuthString: String) {
        let AppName = "Todoary"
        let message = "\(AppName)이(가) \(AuthString)에 접근할 수 없습니다.\r\n 설정화면으로 가시겠습니까?"
        
        let alert = CancelMessageAlertViewController(title: "권한 설정하기", message: message)
        alert.alertHandler = {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)}
        
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
     
    }
}

//MARK: - Helpers

//텍스트뷰에 패딩 넣기
extension UITextView {
    func addLeftPadding() {
        self.textContainerInset = UIEdgeInsets(top: 14, left: 5, bottom: 0, right: 10)
        self.scrollIndicatorInsets = self.textContainerInset
    }
}

// 버튼에 패딩 넣기
class AddPaddingButtton : UIButton {
    var padding = UIEdgeInsets(top: 1.5, left: 10, bottom: 0, right: 10)
}

//url로 이미지 불러오기
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
