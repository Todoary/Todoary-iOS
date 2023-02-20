//
//  CalendarViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/16.
//

import UIKit

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - UIcomponents
    func initView() {
        
        
        dateFormatterYear.dateFormat = "yyyy"
        dateFormatterMonth.dateFormat = "MM"
        dateFormatterDate.dateFormat = "dd"
        self.year = Int(dateFormatterYear.string(from: now))!
        self.month = Int(dateFormatterMonth.string(from: now))!
        self.today = Int(dateFormatterDate.string(from: now))!
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
    
        components_previous.year = components.year
        components_previous.month = components.month! - 1
        components_previous.day = 1
        
        components_next.year = components.year
        components_next.month = components.month! + 1
        components_next.day = 1
        
        select = -1

        self.calculation()
        
        requestGetTodoByYearMonth(yearMonth: "\(dateFormatterYear.string(from: now))-\(dateFormatterMonth.string(from: now))")
        requestGetDiaryByYearMonth(yearMonth: "\(dateFormatterYear.string(from: now))-\(dateFormatterMonth.string(from: now))")
        
        HomeViewController.bottomSheetVC.todoDate = ConvertDate(year: self.year, month: self.month, date: String(self.today))
    }

    
    func calculation() {
        //해당 달
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        emptyDay = 0 - weekdayAdding
        
        //이전달
        let firstDayOfMonth_previous = cal.date(from: components_previous)
        let firstWeekday_previous = cal.component(.weekday, from: firstDayOfMonth_previous!)
        daysCountInMonth_previous = cal.range(of: .day, in: .month, for: firstDayOfMonth_previous!)!.count
        weekdayAdding_previous = 2 - firstWeekday_previous
        previousEmptyDay = 0 - weekdayAdding_previous
        
        //다음달
        let firstDayOfMonth_next = cal.date(from: components_next)
        let firstWeekday_next = cal.component(.weekday, from: firstDayOfMonth_next!)
        daysCountInMonth_next = cal.range(of: .day, in: .month, for: firstDayOfMonth_next!)!.count
        weekdayAdding_next = 2 - firstWeekday_next
        nextEmptyDay = 0 - weekdayAdding_next
        
        self.month_component = Int(dateFormatterMonth.string(from: firstDayOfMonth!))!
        self.year_component = Int(dateFormatterYear.string(from: firstDayOfMonth!))!
        mainView.year_Month.setTitle(dateFormatterYear.string(from: firstDayOfMonth!)+"년 "+String(self.month_component)+"월", for: .normal)
        
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
        
        self.previousDays.removeAll()
        for day in weekdayAdding_previous...daysCountInMonth_previous {
            if day < 1 {
                self.previousDays.append("")
            } else {
                self.previousDays.append(String(day))
            }
        }
        
        self.nextDays.removeAll()
        for day in weekdayAdding_next...daysCountInMonth_next {
            if day < 1 {
                self.nextDays.append("")
            } else {
                self.nextDays.append(String(day))
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == mainView.weekCollectionView {
            return CGSize(width: view.frame.width/8.5, height: 30)
        }else {
            return CGSize(width: view.frame.width/8.5, height: view.frame.width/8.7)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.weekCollectionView {
            return 7
        }else if collectionView == mainView.previousCollectionView{
            return self.previousDays.count
        }else if collectionView == mainView.collectionView{
            return self.days.count
        }else {
            return self.nextDays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mainView.weekCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCell", for: indexPath) as! WeekCell
            if indexPath.row == 0 {
                cell.weekLabel.textColor = .sunday
            } else if indexPath.row == 6 {
                cell.weekLabel.textColor = .saturday
            } else {
                cell.weekLabel.textColor = .black
            }
            cell.weekLabel.text = weeks[indexPath.row]
            
            return cell
        }else if collectionView == mainView.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
            cell.dateLabel.text = days[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            cell.diary.isHidden = true
            
            if (indexPath.row - emptyDay) >= 1 && (indexPath.row - emptyDay) < 32 {
                if calendarRecord[indexPath.row-emptyDay] != 0{
                    cell.dateLabel.layer.backgroundColor = UIColor.calendarExistColor.cgColor
                    cell.dateLabel.textColor = .black
                }
                if diaryRecord[indexPath.row-emptyDay] != 0{
                    cell.diary.isHidden = false
                }
            }
            
            
            if select == -1 {
                if self.year == year_component && self.month == month_component {
                    if today == (indexPath.row - emptyDay) {
                        cell.dateLabel.textColor = UIColor(red: 49/255, green: 131/255, blue: 255/255, alpha: 1)
                        collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                        cell.isSelected = true
                    }else {
                        cell.dateLabel.textColor = .black
                    }
                }else {
                    if indexPath.row - emptyDay == 1 {
                        collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                        cell.isSelected = true
                    }
                }
            }else {
                if select == (indexPath.row - emptyDay){
                    collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                    cell.isSelected = true
                }
            }
            return cell
        }else if collectionView == mainView.previousCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
            cell.dateLabel.text = previousDays[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            cell.diary.isHidden = true
            
    
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
            cell.dateLabel.text = nextDays[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            cell.diary.isHidden = true
            
            return cell
        }
    }
    
    //셀 선택o
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else{
            fatalError()
        }
        
        select = indexPath.row - emptyDay
        
        cell.dateLabel.layer.backgroundColor = UIColor.calendarSelectColor.cgColor
        cell.dateLabel.textColor = .white
        cell.select.isHidden = false
        
        //선택한 날짜에 맞는 투두 리스트 불러오기
        
        let convertDate = ConvertDate(year: year_component, month: month_component, date: days[indexPath.row])
        
        HomeViewController.bottomSheetVC.todoDate = convertDate
        
        requestGetTodoByDate(convertDate.dateSendServer)
        requestGetDiary(convertDate.dateSendServer)
        
        if self.year == year_component && self.month == month_component {
            if today == (indexPath.row - emptyDay) {
                cell.dateLabel.textColor = UIColor(red: 49/255, green: 131/255, blue: 255/255, alpha: 1)
            }
        }
    }
    
    //셀 선택x
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else{
            fatalError()
        }
        
        cell.select.isHidden = true
        
        if calendarRecord[indexPath.row-emptyDay] != 0 {
            cell.dateLabel.layer.backgroundColor = UIColor.calendarExistColor.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
        }else {
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
        }
        
        if diaryRecord[indexPath.row-emptyDay] != 0 {
            cell.diary.isHidden = false
        }else {
            cell.diary.isHidden = true
        }
        
        if self.year == year_component && self.month == month_component {
            if today == (indexPath.row - emptyDay) {
                cell.dateLabel.textColor = UIColor(red: 49/255, green: 131/255, blue: 255/255, alpha: 1)
            }
        }
        
    }
    
    func requestTodoFirstDayOfMonth(){
        
        let convertDate: ConvertDate!
        
        if self.year == year_component && self.month == month_component {
            convertDate = ConvertDate(year: self.year, month: self.month, date: String(self.today))
        }else {
            convertDate = ConvertDate(year: year_component, month: month_component, date: "1")
        }
        
        HomeViewController.bottomSheetVC.todoDate = convertDate
        requestGetTodoByDate(convertDate.dateSendServer)
        requestGetDiary(convertDate.dateSendServer)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        switch targetContentOffset.pointee.x{
        case 0:
            scrollDirection = .left
        case screenSize.width:
            scrollDirection = .none
        case screenSize.width*2:
            scrollDirection = .right
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        switch scrollDirection{
        case .left:
            select = -1
            components.month = components.month! - 1
            components_previous.month = components_previous.month! - 1
            components_next.month = components_next.month! - 1
            self.calculation()
            mainView.previousCollectionView.reloadData()
            mainView.nextCollectionView.reloadData()
            let date = cal.date(from: components)
            calendarRecord = [Int](repeating: 0, count: 32)
            diaryRecord = [Int](repeating: 0, count: 32)
            
            requestGetTodoByYearMonth(yearMonth: "\(dateFormatterYear.string(from: date!))-\(dateFormatterMonth.string(from: date!))")
            requestGetDiaryByYearMonth(yearMonth: "\(dateFormatterYear.string(from: date!))-\(dateFormatterMonth.string(from: date!))")
            mainView.collectionView.reloadData()
            
            requestTodoFirstDayOfMonth()
            mainView.scrollView.setContentOffset(CGPoint(x: screenSize.width, y: 0), animated: false)
        case .none:
            break
        case .right:
            select = -1
            components.month = components.month! + 1
            components_previous.month = components_previous.month! + 1
            components_next.month = components_next.month! + 1
            self.calculation()
            mainView.previousCollectionView.reloadData()
            mainView.nextCollectionView.reloadData()
            let date = cal.date(from: components)
            calendarRecord = [Int](repeating: 0, count: 32)
            diaryRecord = [Int](repeating: 0, count: 32)
            requestGetTodoByYearMonth(yearMonth: "\(dateFormatterYear.string(from: date!))-\(dateFormatterMonth.string(from: date!))")
            requestGetDiaryByYearMonth(yearMonth: "\(dateFormatterYear.string(from: date!))-\(dateFormatterMonth.string(from: date!))")
            mainView.collectionView.reloadData()
            
            requestTodoFirstDayOfMonth()
            mainView.scrollView.setContentOffset(CGPoint(x: screenSize.width, y: 0), animated: false)
        }
    }
}
