//
//  TodoCalendar.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//

import UIKit

extension TodoCalendarBottomSheetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - UIcomponents
    func initView() {
        
        dateFormatterYear.dateFormat = "yyyy"
        dateFormatterMonth.dateFormat = "MM"
        dateFormatterDate.dateFormat = "dd"
        
        if todoYear != -1 {
            self.year = todoYear
            self.month = todoMonth
            self.today = todoDay
            components.year = todoYear
            components.month = todoMonth
        }else {
            self.year = Int(dateFormatterYear.string(from: now))!
            self.month = Int(dateFormatterMonth.string(from: now))!
            self.today = Int(dateFormatterDate.string(from: now))!
            components.year = cal.component(.year, from: now)
            components.month = cal.component(.month, from: now)
        }
        components.day = 1
        self.calculation()
    }

    
    func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        emptyDay = 0 - weekdayAdding
        
        self.month_component = Int(dateFormatterMonth.string(from: firstDayOfMonth!))!
        self.year_component = Int(dateFormatterYear.string(from: firstDayOfMonth!))!
        self.year_Month.text = dateFormatterYear.string(from: firstDayOfMonth!)+"년 "+String(self.month_component)+"월"
        
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            return CGSize(width: 43, height: 50)
            
        default:
            return CGSize(width: 43, height: 42)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todoWeekCell", for: indexPath) as! TodoWeekCell
            if indexPath.row == 0 {
                cell.weekLabel.textColor = .sunday
            } else if indexPath.row == 6 {
                cell.weekLabel.textColor = .saturday
            } else {
                cell.weekLabel.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
            }
            cell.weekLabel.text = weeks[indexPath.row]
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todoCalendarCell", for: indexPath) as! TodoCalendarCell
            
            cell.dateLabel.text = days[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            
            if today != -1 && today == indexPath.row - emptyDay {
                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                cell.isSelected = true
            }else {
                cell.dateLabel.textColor = .black
            }
            return cell
        }
    }
    
    //셀 선택o
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TodoCalendarCell
        
        cell.dateLabel.layer.backgroundColor = UIColor.calendarSelectColor.cgColor
        cell.dateLabel.textColor = .white
        cell.dateLabel.layer.shadowRadius = 4.0
        cell.dateLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.dateLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.dateLabel.layer.shadowOpacity = 1
        cell.dateLabel.layer.masksToBounds = false
        let firstDayOfMonth = cal.date(from: components)
        let today = String(indexPath.row - emptyDay)
        self.delegate?.calendarComplete(date: dateFormatterYear.string(from: firstDayOfMonth!)+"년 "+String(self.month_component)+"월 "+today+"일",date_api: dateFormatterYear.string(from: firstDayOfMonth!)+"-"+String(self.month_component)+"-"+today)
        hideBottomSheetAndGoBack()
    }
    //셀 선택x
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TodoCalendarCell
        
        cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
        cell.dateLabel.textColor = .black
        cell.dateLabel.layer.shadowRadius = 0
        cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
        cell.dateLabel.layer.shadowOpacity = 0
    }
    
    
    
    @objc func prevBtnDidTap() {
        components.month = components.month! - 1
        today = -1
        self.calculation()
        self.collectionView.reloadData()
    }
    
    @objc func nextBtnDidTap() {
        components.month = components.month! + 1
        today = -1
        self.calculation()
        self.collectionView.reloadData()
    }
    
    
}

