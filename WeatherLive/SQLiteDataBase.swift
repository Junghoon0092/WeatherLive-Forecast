

import Foundation
import SQLite

enum DataAccessError : ErrorType {
    case Data_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

class SQLiteDataBase {
    
    static let sharedInstance = SQLiteDataBase()
    let DB : Connection?
    
    private init() {
        var path = "weather.sqlite"
        
        if let dirs : [NSString] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as [NSString] {
            let dir = dirs[0]
            path = dir.stringByAppendingPathComponent("weather.sqlite")
            print(path)
        }
        do {
            DB = try Connection(path)
        }
        catch _ {
            DB = nil
        }
    }
    
    func createTables() throws {
        do {
            try WeatherDBHelper.createTable()
        } catch {
            throw DataAccessError.Data_Connection_Error
        }
        
    }
    
    
    
}