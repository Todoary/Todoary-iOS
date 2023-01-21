//
//  DiaryViewController+Sticker.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

import UIKit
import StickerView

extension DiaryViewController{
    
    struct Sticker {
        let stickerType: Int
        let sticker : StickerView
        var flip : Bool
    }
    
    func checkStickerStateAndRequestApi(){
        if create.isEmpty == false {
            for i in 0...create.count - 1 {
                
                let new = CreatedDiaryStickerRequestModel(stickerId: create[i].stickerType, locationX: Double(create[i].sticker.center.x), locationY: Double(create[i].sticker.center.y), width: create[i].sticker.contentView.frame.height, height: create[i].sticker.contentView.frame.height, rotation: atan2(create[i].sticker.transform.b,create[i].sticker.transform.a) , flipped: create[i].flip)
                
                createdApi.append(new)
            }
        }
        
        if modify.isEmpty == false {
            for i in 0...modify.count - 1 {
                
                let old = ModifiedDiaryStickerRequestModel(id:modify[i].sticker.tag ,stickerId: modify[i].stickerType, locationX: Double(modify[i].sticker.center.x), locationY: Double(modify[i].sticker.center.y), width: modify[i].sticker.contentView.frame.height, height: modify[i].sticker.contentView.frame.height, rotation: atan2(modify[i].sticker.transform.b,modify[i].sticker.transform.a) , flipped: modify[i].flip)
                
                modifiedApi.append(old)
            }
        }
        
        let diaryStickerRequest = DiaryStickerRequestModel(created: createdApi, modified: modifiedApi, deleted: delete)
        
        requestModifyDiarySticker(date: self.pickDate!.dateSendServer, parameter: diaryStickerRequest)
    }
    
    func requestGetDiarySticker(parameter: String){
        DiaryService.shared.getDiarySticker(date: parameter){ [self] result in
            switch result{
            case .success(let data):
                if let diaryStickerData = data as? [DiaryStickerResultModel]{
                    print("[requestGetDiarySticker] success")
                    if diaryStickerData.isEmpty == false {
                        for i in 0...diaryStickerData.count - 1 {
                            
                            let image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: diaryStickerData[i].width, height: diaryStickerData[i].height))
                            image.image = DiaryViewController.stickerData[diaryStickerData[i].stickerId]
                            image.contentMode = .scaleAspectFit
                            
                            if diaryStickerData[i].flipped == true {
                                image.transform = image.transform.scaledBy(x: -1, y: 1)
                            }
                            
                            let sticker = StickerView.init(contentView: image)
                            sticker.center = CGPoint.init(x: diaryStickerData[i].locationX, y: diaryStickerData[i].locationY)
                            sticker.transform = sticker.transform.rotated(by: diaryStickerData[i].rotation)
                            sticker.delegate = self
                            sticker.setImage(UIImage.init(named: "close")!, forHandler: StickerViewHandler.close)
                            sticker.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
                            sticker.setImage(UIImage.init(named: "flip")!, forHandler: StickerViewHandler.flip)
                            sticker.showEditingHandlers = false
                            sticker.tag = diaryStickerData[i].id
                            self.mainView.textView.addSubview(sticker)
                            
                            let stickerInfo = Sticker(stickerType: diaryStickerData[i].stickerId, sticker: sticker, flip: diaryStickerData[i].flipped)
                            
                            modify.append(stickerInfo)
                            
                        }
                    }
                }
                break
            case .invalidSuccess(let code):
                switch code{
                case 2402:
                    print("해당날짜에 일기존재X")
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
    
    func requestModifyDiarySticker(date: String, parameter: DiaryStickerRequestModel){
        DiaryService.shared.modifyDiarySticker(date: date, request: parameter){ [self] result in
            switch result{
            case .success:
                print("[requestModifyDiarySticker] success")
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    //스티커뷰 선택 제스쳐
    func setupGestureRecognizerOnCollection() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSticker(gestureRecognizer:)))
        tapGesture.delegate = self
        DiarySticker.collectionView?.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapSticker(gestureRecognizer: UIGestureRecognizer) {

        let p = gestureRecognizer.location(in: DiarySticker.collectionView)
        
        if let indexPath = DiarySticker.collectionView?.indexPathForItem(at: p) {
            
            tag += 1
            
            let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            testImage.image = DiaryViewController.stickerData[indexPath.row]
            testImage.contentMode = .scaleAspectFit
            
            let sticker = StickerView.init(contentView: testImage)
            sticker.center = CGPoint.init(x: 150, y: 150)
            sticker.delegate = self
            sticker.setImage(UIImage.init(named: "close")!, forHandler: StickerViewHandler.close)
            sticker.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
            sticker.setImage(UIImage.init(named: "flip")!, forHandler: StickerViewHandler.flip)
            sticker.showEditingHandlers = false
            sticker.tag = tag
            self.mainView.textView.addSubview(sticker)
            self.selectedStickerView = sticker
            
            let stickerInfo = Sticker(stickerType: indexPath.row, sticker: sticker, flip: false)
            
            create.append(stickerInfo)
        }
    }
}

extension DiaryViewController: StickerViewDelegate{
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        if stickerView.showEditingHandlers == false {
            self.selectedStickerView = stickerView
            stickerView.showEditingHandlers = true
        }else {
            stickerView.showEditingHandlers = false
        }
    }
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {

    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
        if create.isEmpty == false{
            for i in 0...create.count - 1 {
                if create[i].sticker.tag == stickerView.tag{
                    create.remove(at: i)
                    break
                }
            }
        }
        
        if modify.isEmpty == false {
            for i in 0...modify.count - 1 {
                if modify[i].sticker.tag == stickerView.tag{
                    modify.remove(at: i)
                    delete.append(stickerView.tag)
                    break
                }
            }
        }
    }
    
    func stickerViewDidFlip(_ stickerView: StickerView) {
        
        if create.isEmpty == false {
            for i in 0...create.count - 1 {
                if create[i].sticker.tag == stickerView.tag{
                    create[i].flip.toggle()
                    break
                }
            }
        }
        
        if modify.isEmpty == false {
            for i in 0...modify.count - 1 {
                if modify[i].sticker.tag == stickerView.tag{
                    modify[i].flip.toggle()
                    break
                }
            }
        }
    }
}
