//
//  ScreenSettingViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class ScreenSettingViewController: UIViewController {
    
    var navigationView: NavigationView!
    
    var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
            $0.navigationTitle.text = "화면"
        }

        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.isScrollEnabled = false
            $0.separatorStyle = .none
            
            $0.register(DefaultTableViewCell.self, forCellReuseIdentifier: "screenSettingCell")
        }
        
        setUpView()
        setUpConstraint()

    }

}

extension ScreenSettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "screenSettingCell", for: indexPath) as? DefaultTableViewCell else{
            fatalError()
        }
        
        switch indexPath.row{
        case 0:
            cell.cellTitle.text = "글꼴"
            return cell
        case 1:
            cell.cellTitle.text = "화면테마"
            return cell
        default:
            fatalError("TableView Cell indexing Error")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            print("?")
            self.navigationController?.pushViewController(FontSettingViewController(), animated: true)
            return
        case 1:
            print("!")
            return
        default:
            return
        }
    }
}
