//
//  FontSettingViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class FontSettingViewController: BaseViewController {
    
    var tableView: UITableView!
    
    var currentFontIndex : IndexPath = [0,0]
    
    var currentFontCell : FontSettingTableViewCell?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationTitle.text = "글꼴"
        
        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            
            $0.register(FontSettingTableViewCell.self, forCellReuseIdentifier: "fontSettingCell")
        }
        
        setUpView()
        setUpConstraint()
    }

}

extension FontSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: FontSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fontSettingCell", for: indexPath) as? FontSettingTableViewCell else{
            return UITableViewCell()
        }
        
        cell.cellTitle.text = "글꼴\(indexPath.row+1)"
        
        //초기 세팅
        if(currentFontIndex == indexPath){
            cell.radioButton.isSelected = true
            currentFontCell = cell
        }
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(currentFontIndex != indexPath){
            
            //이전 select cell 해제
            currentFontCell?.radioButton.isSelected = false
            
            //새로운 cell 선택
            let newCell = tableView.cellForRow(at: indexPath) as? FontSettingTableViewCell
            newCell?.radioButton.isSelected = true
            currentFontIndex = indexPath
            currentFontCell = newCell
        }
    }
    
}
