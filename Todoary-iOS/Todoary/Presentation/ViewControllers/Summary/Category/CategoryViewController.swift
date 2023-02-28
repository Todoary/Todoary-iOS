//
//  CategoryViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryViewController: BaseViewController, Pageable {
    
    //MARK: - Properties
    
    var page: Int = 0
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    
    private var isCategoryAdd = false
    private var isEditingMode = false{
        didSet{
            mainView.todoTableView.reloadData()
        }
    }
    private var willDelete = false
    
    let collectionViewInitialIndex: IndexPath = [0,0]
    var selectCategoryIndex : IndexPath!{
        didSet{
            page = 0
            hasNextPage = false
            isEditingMode = false
        }
    }

    var todoData = [TodoResultModel](){
        didSet{
            if(willDelete){
                return
            }
            isPaging = false
            mainView.todoTableView.reloadData()
        }
    }
    var categories = [CategoryModel](){
        didSet{
            mainView.categoryCollectionView.reloadData()
        }
    }
    
    let mainView = CategoryView()
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        requestGetCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(TodoManager.shared.isAdd){
            page = 0
            hasNextPage = false
            isEditingMode = false
            requestGetTodoByCategory()
            TodoManager.shared.initialize()
        }
        requestGetCategories()
    }
    
    override func style() {
        super.style()
        setRightButtonWithImage(Image.categoryTrash)
    }
    
    override func layout() {
        super.layout()
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        
        selectCategoryIndex = collectionViewInitialIndex
        
        mainView.todoTableView.delegate = self
        mainView.todoTableView.dataSource = self
        
        mainView.categoryCollectionView.delegate = self
        mainView.categoryCollectionView.dataSource = self
        
        self.rightButton.addTarget(self, action: #selector(trashButtonDidClicked), for: .touchUpInside)
    }
    
    //MARK: - Action
    
    @objc private func trashButtonDidClicked(){
        isEditingMode.toggle()
    }
    
    @objc func categoryBottomSheetWillShowAndModifyCategory(_ gesture : UILongPressGestureRecognizer){ //카테고리 수정
        guard let index = (mainView.categoryCollectionView.indexPath(for: gesture.view! as! UICollectionViewCell)) else { return }
        
        let vc = CategoryBottomSheetViewController().show(in: self).then{
            $0.currentData = categories[index.row]
            $0.mainView.categoryTextField.text = categories[index.row].title
            $0.currentCategoryCount = categories.count
            $0.completion = {
                self.requestGetCategories()
            }
        }
    }
    
    func showDeleteCompleteToastMessage(){
        
        let toast = ToastMessageView(message: DeleteType.Todo.rawValue)
        
        self.view.addSubview(toast)
        
        toast.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(81)
            make.trailing.equalToSuperview().offset(-81)
            make.bottom.equalToSuperview().offset(-39)
        }
        
        UIView.animate(withDuration: 1.0, delay: 1.8, options: .curveEaseOut, animations: {
              toast.alpha = 0.0
          }, completion: {(isCompleted) in
              toast.removeFromSuperview()
          })
    }
}

//MARK: - API
extension CategoryViewController: CategoryTodoCellDelegate{

    private func requestGetCategories(){
        CategoryService.shared.getCategories{ result in
            switch result {
            case .success(let data):
                print("[requestGetCategories] success")
                if let data = data as? [CategoryModel]{
                    self.categories = data
                    self.isCategoryAdd = false
                    self.processResponseGetCategories()
                }
                break
            default:
                print("[requestGetCategories] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    private func processResponseGetCategories(){
        
        if(selectCategoryIndex.row == categories.count){ //마지막에 위치한 category 삭제했을 경우, 그 이전 category를 select 상태로..
            selectCategoryIndex = [0, categories.count - 1]
            mainView.categoryCollectionView.reloadData()
        }
        
        if(isCategoryAdd){
            mainView.categoryCollectionView.scrollToItem(at: [0, categories.count], at: .right, animated: true)
            isCategoryAdd = false
        }

        requestGetTodoByCategory()
    }
    
    private func requestGetTodoByCategory(){
        
        let categoryId: Int = categories.count == 1 ? categories[0].id : categories[selectCategoryIndex.row].id
        
        TodoService.shared.getTodoByCategory(id: categoryId, page: page) { result in
            switch result {
            case .success(let data):
                print("[getTodoByCategory] success", data)
                if let data = data as? PageableResponseModel{
                    self.processResponseGetTodo(data: data)
                }
                break
            default:
                print("[getTodoByCategory] fail", result)
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    private func processResponseGetTodo(data: PageableResponseModel){
        
        hasNextPage = !data.isLast
        
        if(page == 0){
            todoData = data.contents
        }else{
            todoData.append(contentsOf: data.contents)
        }
        
        if(data.isEmpty){
            todoRequestIsEmpty()
        }
    }
    
    func todoRequestIsEmpty() {
        isPaging = false
        mainView.todoTableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    func requestDeleteTodo(cell: CategoryTodoTableViewCell) {
        guard let indexPath = mainView.todoTableView.indexPath(for: cell) else { return }
        let todo = todoData[indexPath.row]
        
        TodoService.shared.deleteTodo(id: todo.todoId){ result in
            switch result{
            case .success:
                print("LOG: SUCCESS requestDeleteTodo")
                self.processResponseDeleteTodo(indexPath: indexPath)
                break
            default:
                print("LOG: fail requestDeleteTodo")
                DataBaseErrorAlert.show(in: self)
                break
            }
            
        }
    }
    
    private func processResponseDeleteTodo(indexPath: IndexPath){
        willDelete = true
        todoData.remove(at: indexPath.row)
        
        if(todoData.count == 0){
            isEditingMode = false
            mainView.todoTableView.reloadData()
        }else{
            mainView.todoTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        showDeleteCompleteToastMessage()
        willDelete = false
    }
    
    func requestPatchTodoCheckStatus(cell: CategoryTodoTableViewCell) {
        
        guard let index = mainView.todoTableView.indexPath(for: cell) else { return }
        
        todoData[index.row].isChecked.toggle()
        let data = todoData[index.row]
        
        TodoService.shared.modifyTodoCheckStatus(id: data.todoId, isChecked: data.isChecked){ result in
            switch result{
            case .success(_):
                print("[requestPatchTodoCheckStatus] success")
                break
            default:
                print("[requestPatchTodoCheckStatus] fail")
                self.todoData[index.row].isChecked.toggle()
                DataBaseErrorAlert.show(in: self)
                break
            }
            
        }
    }
}

//MARK: - TableView
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return todoData.count != 0 ? todoData.count + 1 : 2
        }else if(section == 1 && isPaging && hasNextPage){
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LoadingTableViewCell.self).then{
                $0.startLoading()
            }
            return cell
        }
        
        if(indexPath.row ==  tableView.numberOfRows(inSection: 0) - 1){
            return tableView.dequeueReusableCell(for: indexPath, cellType: AddTodoInCategoryTableViewCell.self)
        }
            
        if(todoData.count == 0){
            return tableView.dequeueReusableCell(withIdentifier: NoTodoInCategoryTableViewCell.cellIdentifier, for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CategoryTodoTableViewCell.self)
        
        cell.delegate = self
        
        let todo = todoData[indexPath.row]
        cell.bindingData(todo)
        
        let leading = isEditingMode ? 58 : 32
        let trailing = isEditingMode ? -4 : -30
        
        cell.contentView.snp.updateConstraints{
            $0.leading.equalToSuperview().offset(leading)
            $0.trailing.equalToSuperview().offset(trailing)
        }
        
        cell.deleteButton.isHidden = !isEditingMode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == tableView.numberOfRows(inSection: 0) - 1){
            let vc = TodoSettingViewController()
            TodoSettingViewController.selectCategory = categories[selectCategoryIndex.row].id
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        if(!todoData.isEmpty && indexPath.row != tableView.numberOfRows(inSection: 0) - 1){
            let vc = TodoSettingViewController()
            vc.completion = {
                self.todoData[indexPath.row] = $0
            }
            vc.todoSettingData = todoData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - CollectionView
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.row == categories.count){
            return collectionView.dequeueReusableCell(for: indexPath, cellType: CategoryAddCollectionViewCell.self)
        }

        let data = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CategoryTagCollectionViewCell.self).then{
            $0.bindingData(title: data.title, color: data.color)
            $0.addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                                 action: #selector(categoryBottomSheetWillShowAndModifyCategory)))
            if(indexPath == selectCategoryIndex){
                $0.setSelectState()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.row == categories.count){
            return CategoryAddCollectionViewCell.cellSize
        }
        
        let title = categories[indexPath.row].title
        return CategoryTag.estimatedSize(title)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if(indexPath.row == categories.count){
            let vc = CategoryBottomSheetViewController().show(in: self)
            vc.mainView.deleteBtn.setTitle("취소", for: .normal)
            vc.completion = {
                self.isCategoryAdd = true
                self.requestGetCategories()
            }
            return false
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath == selectCategoryIndex){
            return
        }
        
        if(indexPath != collectionViewInitialIndex && selectCategoryIndex == collectionViewInitialIndex){
            guard let cell = mainView.categoryCollectionView.cellForItem(at: collectionViewInitialIndex) as? CategoryTagCollectionViewCell else { return }
            cell.setDeselectState()
        }
        
        guard let cell = mainView.categoryCollectionView.cellForItem(at: indexPath) as? CategoryTagCollectionViewCell else { return }
        cell.setSelectState()

        selectCategoryIndex = indexPath
        requestGetTodoByCategory()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = mainView.categoryCollectionView.cellForItem(at: indexPath) as? CategoryTagCollectionViewCell else { return }
        cell.setDeselectState()
    }
}

//MARK: - Pageable

 extension CategoryViewController{
 
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offsetY = scrollView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let height = scrollView.frame.height
         
         // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
         if offsetY > (contentHeight - height) {
             if isPaging == false && hasNextPage {
                 print("여기?")
                 beginPaging()
             }
         }
     }
     
     func beginPaging(){
         isPaging = true
         page = page + 1

         DispatchQueue.main.async { [self] in
             mainView.todoTableView.reloadSections(IndexSet(integer: 1), with: .none)
         }

         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             self.requestGetTodoByCategory()
         }
     }
 }
 
