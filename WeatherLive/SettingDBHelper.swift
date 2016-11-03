
import Foundation
import SQLite

class SettingDBHelper : DBHelperProtocol {
    
    static let TABLE_NAME = "admin"
    static let table = Table(TABLE_NAME)
    static let id = Expression<Int64>("id")
    static var tempCheck = Expression<Int64>("tempCheck")
    
    typealias T = SettingItem
    static func createTable() throws {
        
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        
        do{
            let _ = try DB.run(table.create(ifNotExists : true ) { t in
                t.column(id, primaryKey: false)
                t.column(tempCheck, defaultValue: 0)
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
        if (item.tempCheck != nil ) {
            let insert = table.insert(id <- item.id!, tempCheck <- item.tempCheck!)
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
    
    static func update(item: T) throws {
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        let query = table.filter(id == item.id)
        do {
            let tmp = try DB.run(query.update(id <- item.id, tempCheck <- item.tempCheck))
            print("tmp : \(tmp)")
            guard tmp == 1 else {
                print("table Update Error")
                throw DataAccessError.Delete_Error
            }
        }catch _ {
            throw DataAccessError.Delete_Error
        }
    }
    
    static func delete(item: T) throws {
        guard let DB = SQLiteDataBase.sharedInstance.DB else {
            print("connection Error")
            throw DataAccessError.Data_Connection_Error
        }
        let query = table.filter(tempCheck == item.getTempCheck())
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
        let query = table.filter(self.tempCheck == tempCheck)
        let items = try DB.prepare(query)
        for item in items {
            
            return SettingItem(id: item[self.id], tempCheck : item[self.tempCheck])
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
            retArry.append(SettingItem(id: item[self.id] ,tempCheck: item[self.tempCheck]))
        }
        return retArry
    }
    
    
}

