//
//  CategoryViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - UI
    
    var navigationView : NavigationView!

    lazy var trashButton = UIButton().then{
        $0.setImage(UIImage(named: "category_trash"), for: .normal)
        $0.addTarget(self, action: #selector(trashButtonDidClicked), for: .touchUpInside)
    }

    var collectionView : UICollectionView!

    var tableView : UITableView!
    
    var isEditingMode = false
    
//    var currentCategory : CategoryButtonCollectionViewCell!
    var currentCategoryIndex : IndexPath = [0,0]

    var todoData: [GetTodoInfo]! = []
    
    var categories : [GetCategoryResult] = []
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationView = NavigationView(frame: .zero, self.navigationController!)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = CGFloat(8)
        
        collectionView = UICollectionView(frame: .init(), collectionViewLayout: flowLayout).then{
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false

            $0.register(CategoryPlusButtonCell.self, forCellWithReuseIdentifier: CategoryPlusButtonCell.cellIdentifier)
            $0.register(CategoryButtonCollectionViewCell.self, forCellWithReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier)
        }
        
        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            $0.register(CategoryTodoTableViewCell.self, forCellReuseIdentifier: CategoryTodoTableViewCell.cellIdentifier)
            $0.register(NewTodoAddBtnTableViewCell.self, forCellReuseIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier)
            
        }
        
        setUpView()
        setUpConstraint()
        
        //category 조회
        GetCategoryDataManager().get(self)
    }
    
    //MARK: - Action
    
    @objc
    func trashButtonDidClicked(){
        
        let leading: Int!
        let trailing: Int!
        
        if(isEditingMode){
            leading = 32
            trailing = -30
        }else{
            leading = 58
            trailing = -4
        }
        
        var i = 0
        while(i < todoData.count){
            guard let cell = tableView.cellForRow(at: [0,i]) as? CategoryTodoTableViewCell else{
                fatalError()
            }
            cell.contentView.snp.updateConstraints{ make in
                make.leading.equalToSuperview().offset(leading)
                make.trailing.equalToSuperview().offset(trailing)
            }
            cell.deleteButton.isHidden.toggle()
            i = i + 1
        }
        isEditingMode.toggle()
    }

}

//MARK: - TableView
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row != tableView.numberOfRows(inSection: 0)-1){
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTodoTableViewCell.cellIdentifier) as? CategoryTodoTableViewCell else{
                fatalError()
            }
            
            let cellData = todoData[indexPath.row]
            cell.settingTodoData(cellData)
            cell.navigation = self.navigationController
            cell.viewController = self
            
            return cell
            
        } else{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier) as? NewTodoAddBtnTableViewCell else{
                fatalError()
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(indexPath.row == todoData.count){
            return false
        }else{
            return true
        }
    }

}

//MARK: - CollectionView
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.row != categories.count){
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier, for: indexPath) as? CategoryButtonCollectionViewCell else { fatalError()}
            
            let categoryData = categories[indexPath.row]
            
            cell.viewController = self
            cell.categoryData = categoryData
            cell.setBtnAttribute()
            
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(categoryDidPressedLong))
            cell.addGestureRecognizer(longPress)
            
            if(indexPath == currentCategoryIndex){
                cell.buttonIsSelected()
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryPlusButtonCell.cellIdentifier, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.row != categories.count){
            let categoryTitle = categories[indexPath.row].title
            
            let tmpLabel = UILabel()
            tmpLabel.text = categoryTitle
            
            if(categoryTitle.count > 2){
                tmpLabel.then{
                    $0.font = UIFont.nbFont(ofSize: 14, weight: .bold)
                    $0.addLetterSpacing(spacing: 0.28)
                }
            }
            
            return CGSize(width: Int(tmpLabel.intrinsicContentSize.width+32), height: 26)
            
        }else{
            return CGSize(width: 50, height: 26)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.row == categories.count){
            let vc = ColorPickerBottomsheetViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.categoryVC = self
            vc.deleteBtn.setTitle("삭제", for: .normal)
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @objc
    func categoryDidPressedLong(_ gesture : UILongPressGestureRecognizer){
        
        guard let index = (collectionView.indexPath(for: gesture.view! as! UICollectionViewCell)) else { return }
        
        let vc = ColorPickerBottomsheetViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        vc.categoryVC = self
        vc.categoryTextField.text = categories[index.row].title
        vc.currentColorIndex = [0, categories[index.row].color]
        
        self.present(vc, animated: false, completion: nil)
    }
    
}

//MARK: - API
extension CategoryViewController{
    
    func checkGetCategoryApiResultCode(_ result: [GetCategoryResult]){
        self.categories = result
        collectionView.reloadData()
        
        if(self.categories != []){
            TodoGetByCategoryDataManager().get(viewController: self, categoryId: categories[0].id)
        }
    }
    
    func checkGetTodoApiResultCode(_ result: GetTodoModel){
        switch result.code{
        case 1000:
            todoData = result.result
            tableView.reloadData()
//            currentCategory.buttonIsSelected()
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    /*
    func checkGetTodoApiResultCode(_ cell: CategoryButtonCollectionViewCell, _ result: GetTodoModel){
        switch result.code{
        case 1000:
            
            cell.buttonIsSelected()
            currentCategory.buttonIsNotSelected()
            currentCategory = cell

            todoData = result.result
            tableView.reloadData()
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
     */
    
    func checkGetTodoApiResultCode(_ indexPath: IndexPath, _ result: GetTodoModel){
        switch result.code{
            
        case 1000:
            print("여기임?")
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryButtonCollectionViewCell else{
                return
            }
            cell.buttonIsSelected()
            
            guard let preCell = collectionView.cellForItem(at: currentCategoryIndex)as? CategoryButtonCollectionViewCell else{
                return
            }
            
            print("카테고리별 조회 성공", indexPath)
            preCell.buttonIsNotSelected()
//            currentCategory = cell
            currentCategoryIndex = indexPath

            todoData = result.result
            tableView.reloadData()
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    func checkDeleteApiResultCode(code: Int, indexPath : IndexPath){
        switch code{
        case 1000:
            todoData.remove(at: indexPath.row)
            tableView.reloadData()
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
}
