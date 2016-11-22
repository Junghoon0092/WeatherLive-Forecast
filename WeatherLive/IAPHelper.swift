//
//  IAPHelper.swift
//  InApp Template
//
//  Created by Johannes Ruof on 22.09.16.
//  Copyright © 2016 Rume Academy. All rights reserved.
//

import StoreKit

public typealias RUMEProductIdentifier = String
public typealias RUMEProductRequestCompletionHandler = (success: Bool, products: [SKProduct]?) -> ()

// MARK: - Class

public class IAPHelper: NSObject {
    
    private let rumeProductIdentifiers: Set<RUMEProductIdentifier>
    private var rumePurchasedProductIdentifiers = Set<RUMEProductIdentifier>()
    
    private var rumeProductsRequest: SKProductsRequest?
    private var rumeProductsRequestCompletionHandler: RUMEProductRequestCompletionHandler?
    
    static let rumeIAPHelperPurchaseNotification = "IAPHelperPurchaseNotification"
    
    public init(productIDs: Set<RUMEProductIdentifier>) {
        rumeProductIdentifiers = productIDs
        
        for productIdentifier in productIDs {
            let purchased = NSUserDefaults.standardUserDefaults().boolForKey(productIdentifier)
            if purchased {
                rumePurchasedProductIdentifiers.insert(productIdentifier)
                print("Already purchased \(productIdentifier)")
            } else {
                print("Not yet purchased \(productIdentifier)")
            }
        }
        
        super.init()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }
    
    public func requestProducts(completionHandler: RUMEProductRequestCompletionHandler) {
        rumeProductsRequest?.cancel()
        rumeProductsRequestCompletionHandler = completionHandler
        
        rumeProductsRequest = SKProductsRequest(productIdentifiers: rumeProductIdentifiers)
        rumeProductsRequest?.delegate = self
        rumeProductsRequest?.start()
    }
    
    public func buyProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)

    }
    
    public func isProductPurchased(productIdentifier: RUMEProductIdentifier) -> Bool {
        return rumePurchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public class func canMakePayment() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    
}

// MARK: - SKProductRequestsDelegate

extension IAPHelper: SKProductsRequestDelegate {
    public func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        let products = response.products
        rumeProductsRequestCompletionHandler?(success: true, products: products)
        reset()
    }
    
    public func request(request: SKRequest, didFailWithError error: NSError) {
        rumeProductsRequestCompletionHandler?(success: false, products: nil)
        reset()
        print("Error: \(error.localizedDescription)")
    }
    
    
    private func reset() {
        rumeProductsRequest = nil
        rumeProductsRequestCompletionHandler = nil
    }
    
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {
    
    public func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case SKPaymentTransactionState.Purchased:
                completeTransaction(transaction)
            case SKPaymentTransactionState.Failed:
                completeTransaction(transaction)
            case SKPaymentTransactionState.Deferred:
                break
            case SKPaymentTransactionState.Purchasing:
                break
            default:
                break
            }
        }
        
    }
    
    private func completeTransaction(transaction: SKPaymentTransaction) {
        postPurchaseNotificationForIdentifier(transaction.payment.productIdentifier)
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func failedTransaction(transaction: SKPaymentTransaction) {
        if transaction.error?.code != SKErrorCode.PaymentCancelled.rawValue {
            print("Error: \(transaction.error?.localizedDescription)")
        }
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func restoreTransaction(transaction: SKPaymentTransaction) {
        
        guard let productsIdentifier = transaction.originalTransaction?.payment.productIdentifier else {
            return
        }
        postPurchaseNotificationForIdentifier(productsIdentifier)
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func postPurchaseNotificationForIdentifier(identifier: String?) {
        guard let identifier = identifier else {
            return
        }
        
        rumePurchasedProductIdentifiers.insert(identifier)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: identifier)
        NSUserDefaults.standardUserDefaults().synchronize()

        NSNotificationCenter.defaultCenter().postNotificationName(IAPHelper.rumeIAPHelperPurchaseNotification, object: identifier)
    }
    
}
