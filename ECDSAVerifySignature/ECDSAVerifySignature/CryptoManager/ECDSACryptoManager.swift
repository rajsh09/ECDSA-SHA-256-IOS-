//
//  ECDSACryptoManager
//
//  Created by Rajan on 22/05/20.
//  Copyright © 2020 Daily Dozen. All rights reserved.
//

import UIKit

// SECP256R1 EC public key header
private let kCryptoManagerSecp256r1headerLen = 26
//EC 256r1 public key header..
/*
 [0x30, 0x59, 0x30, 0x13, 0x06, 0x07, 0x2A, 0x86, 0x48, 0xCE, 0x3D, 0x02, 0x01, 0x06, 0x08, 0x2A, 0x86, 0x48, 0xCE, 0x3D, 0x03, 0x01, 0x07, 0x03, 0x42, 0x00]
 **/

class ECDSACryptoManager: NSObject {
   
    func validateECDSA256r1Signature(publicKey:String, plainText:String ,signature:String)->String {
        guard let signData = Data.init(base64Encoded:signature) as CFData?, let plainData = plainText.data(using: .utf8) as CFData? else{
            return "Unable to parse data given for verification"
        }
        let secKey = self.publicKeyValidation(publicKey:publicKey)
        var verified = false;
        var verifyError: Unmanaged<CFError>? = nil
        
        if let secPublicNewKey = secKey {
            if #available(iOS 10.0, *) {
                verified = SecKeyVerifySignature(
                    secPublicNewKey,
                    SecKeyAlgorithm.ecdsaSignatureMessageX962SHA256,
                    plainData,
                    signData,
                    &verifyError
                )
                return "Verification \(verified)"
            } else {
                return "Fallback on earlier versions (valid for 10.0 and above)"
            }
        }else {
            return "Invalid public key use only 256 EC r1 public key"
        }
    }
    
    func getSecKeyFromRawBytes(_ rawBytes: Data) -> SecKey? {
         var error: Unmanaged<CFError>? = nil
         if #available(iOS 10.0, *) {
           let keySec = SecKeyCreateWithData(rawBytes as NSData, [
             kSecAttrKeyType: kSecAttrKeyTypeEC,
             kSecAttrKeyClass: kSecAttrKeyClassPublic,
             kSecAttrKeySizeInBits: 256
             ] as NSDictionary, &error)
              print("Sec Key data",keySec as Any)
             return keySec
         } else {
           // Fallback on earlier versions
           return nil
         }
       }
      
      func stripPublicKey(_ publicKey: Data) -> Data? {
      
        print("Before Strip EC key: \(publicKey.hexString)")
        let curveOIDHeaderLen: Int
        curveOIDHeaderLen = kCryptoManagerSecp256r1headerLen
        let offset = curveOIDHeaderLen
        let size = publicKey.count - curveOIDHeaderLen
        
        let segment: Data = publicKey.withUnsafeBytes { buf in
            let mbuf = UnsafeMutablePointer(mutating: buf.bindMemory(to: UInt8.self).baseAddress!)
            return Data(bytesNoCopy: mbuf.advanced(by: offset), count: size, deallocator: .none)
        }
        print("After Strip EC key: \(segment.hexString)")
        return segment
      }
    
  public func publicKeyValidation(publicKey:String) ->SecKey? {
      let data = Data.init(base64Encoded: publicKey)!
      let pKeyData = self.stripPublicKey(data)!
      return self.getSecKeyFromRawBytes(pKeyData)
  }

}



extension Data {
    var hexString: String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}
