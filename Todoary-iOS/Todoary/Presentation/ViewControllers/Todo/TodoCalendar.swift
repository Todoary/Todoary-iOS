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
            
            select_year = todoYear
            select_month = todoMonth
            select_day = todoDay
            
            components.year = todoYear
            components.month = todoMonth
            
            components_previous.year = components.year
            components_previous.month = components.month! - 1
            components_previous.day = 1
            
            components_next.year = components.year
            components_next.month = components.month! + 1
            components_next.day = 1
            
        }else {
            self.year = Int(dateFormatterYear.string(from: now))!
            self.month = Int(dateFormatterMonth.string(from: now))!
            self.today = Int(dateFormatterDate.string(from: now))!
            
            select_year = self.year
            select_month = self.month
            select_day = self.today
            
            components.year = cal.component(.year, from: now)
            components.month = cal.component(.month, from: now)
            
            components_previous.year = components.year
            components_previous.month = components.month! - 1
            components_previous.day = 1
            
            components_next.year = components.year
            components_next.month = components.month! + 1
            components_next.day = 1
        }
        components.day = 1
        self.calculation()
    }

    
    func calculation() {
        //해당달
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
        self.year_Month.text = dateFormatterYear.string(from: firstDayOfMonth!)+"년 "+String(self.month_component)+"월"
        
        
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
        
        if collectionView == weekCollectionView {
            return CGSize(width: view.frame.width/8.5, height: 20)
        }else {
            return CGSize(width: view.frame.width/8.5, height: view.frame.width/10)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weekCollectionView {
            return 7
        }else if collectionView == previousCollectionView{
            return self.previousDays.count
        }else if collectionView == mainCollectionView{
            return self.days.count
        }else {
            return self.nextDays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == weekCollectionView {
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
        }else if collectionView == mainCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todoCalendarCell", for: indexPath) as! TodoCalendarCell
            
            cell.dateLabel.text = days[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            
            if select_year == components.year && select_month == components.month && select_day == indexPath.row - emptyDay {
                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                cell.isSelected = true
            }else {
                cell.dateLabel.textColor = .black
            }

            return cell
        }else if collectionView == previousCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todoCalendarCell", for: indexPath) as! TodoCalendarCell
            
            cell.dateLabel.text = previousDays[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todoCalendarCell", for: indexPath) as! TodoCalendarCell
            
            cell.dateLabel.text = nextDays[indexPath.row]
            cell.dateLabel.layer.backgroundColor = UIColor.transparent.cgColor
            cell.dateLabel.textColor = .black
            cell.dateLabel.layer.shadowRadius = 0
            cell.dateLabel.layer.shadowColor = UIColor.transparent.cgColor
            cell.dateLabel.layer.shadowOpacity = 0
            
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
        
        select_year = components.year!
        select_month = components.month!
        select_day = indexPath.row - emptyDay
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
    
    
}

extension TodoCalendarBottomSheetViewController: UIScrollViewDelegate {
    
    
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
            today = -1
            components.month = components.month! - 1
            components_previous.month = components_previous.month! - 1
            components_next.month = components_next.month! - 1
            self.calculation()
            previousCollectionView.reloadData()
            nextCollectionView.reloadData()
            mainCollectionView.reloadData()
            
            scrollView.setContentOffset(CGPoint(x: screenSize.width, y: 0), animated: false)
        case .none:
            break
        case .right:
            today = -1
            components.month = components.month! + 1
            components_previous.month = components_previous.month! + 1
            components_next.month = components_next.month! + 1
            self.calculation()
            previousCollectionView.reloadData()
            nextCollectionView.reloadData()
            mainCollectionView.reloadData()
            
            scrollView.setContentOffset(CGPoint(x: screenSize.width, y: 0), animated: false)
        }
    }
}

