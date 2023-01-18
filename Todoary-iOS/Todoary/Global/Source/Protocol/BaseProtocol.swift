//
//  BaseProtocol.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/25.
//

import UIKit

/*
 규칙!
 1. view에는 레이아웃 관련 코드만 (버튼 이벤트등 메서드 작성X)
 2. ViewController에 action, UITableViewDelegate 메서드들 작성
 3. 파일 이름/변수/함수 등에서 네이밍 축약 금지(ex. btn으로 작성했던 것도 다 button으로 넣기)
 4. viewController에 view 프로퍼티 선언할 때 mainView로 네이밍 통일
 
 view -> BaseView 상속
 viewController -> BaseViewController 상속
 cell -> BaseTableViewCell/BaseCollectionViewCell 상속 및 BaseCellProtocol 채택
 */


protocol CellReuseProtocol{ //cell 사용은 아래 예제처럼
    static var cellIdentifier: String { get }
}

extension CellReuseProtocol{
    static var cellIdentifier: String{
        return String(describing: self)
    }
}

/*
 BaseView
 
 1. style //background 같은 프로퍼티 설정 메서드로 optional이니까 필요한 경우에만 선언해서 사용하면 됨
 2. hierarchy //addSubview와 같은 계층 구조를 담는 메서드
 3. layout //snapkit 통한 레이아웃 설정을 담는 메서드

 ---------------------------------------------
 BaseViewcontroller
 
 1. style //background 같은 프로퍼티 설정 메서드로 필요한 경우에만 선언해서 사용하면 됨
 2. layout //BaseViewProtocol과 다르게 layout메서드 하나로 뷰 계층과 레이아웃 설정(mainView만 넣어주면 되므로)
            //mainview 레이아웃 잡을 때 top offset은 Const.Offset.top으로 설정하면 됨(view 네비게이션바 bottom 값 기준으로 offset 수정하기!)
 3. initialize //UITableViewDelegate의 delegat = self 같은 초기화 필요한 코드들 담는 메서드

 ---------------------------------------------
 BaseTableViewCell/BaseCollectionViewCell
 
 1. baseTableViewCell / BaseCollectionViewCell 먼저 선언
 2. cellIdentifier var -> let으로 변경해줘야 함
 3. 필요한 경우 style 메서드 사용
 
class CellExample: BaseCollectionViewCell, BaseCellProtocol{
    
    static let cellIdentifier: String = "z"
    
    func hierarchy() {
        super.hierarchy()
    }
    
    func layout() {
        super.layout()
    }
}
*/
