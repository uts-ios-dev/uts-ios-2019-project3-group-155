//
//  loadInitialValues.swift
//  Money Matter
//
//  Created by Aruna Sairam Manjunatha on 26/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//

import Foundation

class LoadInitialValues{
    
    var percent: Float = 0.0
    var prevCurrencyName: String = ""
    var prevCurrencyValue: Float = 0.0
    var currentCurrencyName: String = ""
    var currentCurrencyValue: Float = 0.0
    var base: String
    var currencyLabel: String
  
    
    init(base: String,currencyLabel: String) {
        self.base = base
        self.currencyLabel = currencyLabel
    }
    
    
    func fetchLiveData()->(Float,Float){
        
            self.fetchJasonOfYesterday(self.base,self.currencyLabel){ (success1) in
                if (success1){
                    self.fetchJasonOfToday(self.base,self.currencyLabel){ (success2) in
                        if (success2){
                            self.calculatePercent(){ (success3) in
                                if (success3){
                                    _ = 2
                                }
                            }
                        }
                    }
                }
            }
       
      sleep(1)
             return (self.currentCurrencyValue,self.percent)
        
    }
    
    func fetchJasonOfYesterday(_ base:String, _ curr:String,completion:@escaping (Bool) -> Void ){
        var success1: Bool = false
        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterday = dateFormatter.string(from: previousDay!)
        print(yesterday)
        
        let jsonURL = "https://apilayer.net/api/historical?access_key=7e4329ef9daa6adce5d7775a6719bcb4&date=\(yesterday)&source=\(base)&currencies=\(curr)"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                return
            }
            do{
                let currencyValue = try
                    JSONDecoder().decode(Currency.self, from: data)
                for (key,value) in currencyValue.quotes{
                    self.prevCurrencyName = key
                    self.prevCurrencyValue = value
                }
                
                print("Yesterday")
                print("Previous Currency Name:\(self.prevCurrencyName), Previous Currency Value:\(self.prevCurrencyValue)")
                
                success1 = true
                completion(success1)
            } catch _{
                print("Unable to fetch the data")
            }
        }
        task.resume()
    }
    
    
    func fetchJasonOfToday(_ base: String,_ curr:String,completion: @escaping (Bool)->Void){
        var success2: Bool = false
        
        let jsonURL = "https://apilayer.net/api/live?access_key=7e4329ef9daa6adce5d7775a6719bcb4&source=\(base)&currencies=\(curr)"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                return
            }
            do{
                let currencyValue = try
                    JSONDecoder().decode(Currency.self, from: data)
                for (key,value) in currencyValue.quotes{
                    self.currentCurrencyName = key
                    self.currentCurrencyValue = value
                }
                print("Today")
                print("Current Currency Name:\(self.currentCurrencyName), Current Currency Value:\(self.currentCurrencyValue)")
                
                success2 = true
                completion(success2)
            } catch _{
                print("Unable to fetch the data")
            }
        }
        task.resume()
    }
    
    
    func calculatePercent(completion:@escaping (Bool) -> Void ){
        var success3: Bool = false
            self.percent = ((self.currentCurrencyValue - self.prevCurrencyValue ) / self.prevCurrencyValue) * 100
            print("\(self.percent)%")
        success3 = true
        completion(success3)
 
        
    }
    
}
