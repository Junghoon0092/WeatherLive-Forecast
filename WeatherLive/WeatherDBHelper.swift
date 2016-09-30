
import Foundation
import SQLite


protocol DBHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(item : T) throws -> Int64
    static func delete(item : T) throws -> Void
    static func finaAll() throws -> [T]?
}

class WeatherDBHelper : DBHelperProtocol {
    
    static let TABLE_NAME = "WeatherLoaction"
    static let table = Table(TABLE_NAME)
    static let id = Expression<Int64>("id")
    static let cityName = Expression<String>("cityname")
    static let latitude = Expression<String>("latitude")
    static let longitude = Expression<String>("longitude")
    
    
    
    typealias T = LocationItem
    static func createTable() throws {
        
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        
        do{
            let _ = try DB.run(table.create(ifNotExists : true ) { t in
                t.column(id, primaryKey : .Autoincrement )
                t.column(cityName)
                t.column(latitude)
                t.column(longitude)
                })
        }catch _ {
            // error
            print("Table Ceate Error")
        }
        
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        if (item.latitude != nil && item.longitude != nil ) {
            let insert = table.insert(cityName <- item.cityName!,
                                      latitude <- item.latitude!,
                                      longitude <- item.longitude!)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            }
            catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
    }
    
    static func delete(item: T) throws {
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        let query = table.filter(id == item.getId())
        do {
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                print("Delete Error")
                throw DataAccessError.Delete_Error
            }
        }catch _ {
            throw DataAccessError.Delete_Error
        }
    }
    
    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        let query = table.filter(self.id == id)
        let items = try DB.prepare(query)
        for item in items {
            
            return LocationItem(id: item[self.id],
                            latitude : item[self.latitude],
                            longitude: item[self.longitude],
                            cityName : item[self.cityName])
        }
        return nil
    }
    
    static func finaAll() throws -> [T]? {
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        var retArry = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArry.append(LocationItem(id: item[self.id],
                latitude: item[self.latitude],
                longitude: item[self.longitude],
                cityName: item[self.cityName]))
        }
        return retArry
    }
    
    
}

