//
//  String+MD5.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation
#if canImport(CryptoKit)
import CryptoKit
#endif

extension String {
    /// Generate MD5 hash of the string
    var md5: String {
        #if canImport(CryptoKit)
        // Use CryptoKit on platforms that support it (macOS 10.15+, iOS 13+)
        let data = Data(self.utf8)
        let hash = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02hhx", $0) }.joined()
        #else
        // Fallback implementation for Linux and older platforms
        return md5HashFallback()
        #endif
    }
    
    #if !canImport(CryptoKit)
    /// Fallback MD5 implementation for platforms without CryptoKit
    private func md5HashFallback() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count: 16)
        
        // Simple MD5 implementation
        data.withUnsafeBytes { bytes in
            MD5_CTX(&digest, bytes.bindMemory(to: UInt8.self).baseAddress!, UInt32(data.count))
        }
        
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Simple MD5 implementation for Linux compatibility
    private func MD5_CTX(_ digest: inout [UInt8], _ input: UnsafePointer<UInt8>?, _ length: UInt32) {
        // This is a simplified MD5 implementation
        // For production use, consider using a proper crypto library like OpenSSL
        
        // MD5 constants
        let S: [UInt32] = [
            7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
            5,  9, 14, 20, 5,  9, 14, 20, 5,  9, 14, 20, 5,  9, 14, 20,
            4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
            6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21
        ]
        
        let K: [UInt32] = [
            0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
            0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
            0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
            0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
            0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
            0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
            0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
            0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
            0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
            0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
            0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
            0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
            0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
            0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
            0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
            0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391
        ]
        
        // Initialize MD5 state
        var h: [UInt32] = [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476]
        
        // Prepare message
        let originalLength = length
        var message = Data()
        if let input = input {
            message.append(input, count: Int(length))
        }
        
        // Padding
        message.append(0x80)
        while (message.count % 64) != 56 {
            message.append(0x00)
        }
        
        // Append length
        let lengthInBits = UInt64(originalLength) * 8
        message.append(contentsOf: withUnsafeBytes(of: lengthInBits.littleEndian) { Array($0) })
        
        // Process message in 512-bit chunks
        for chunkStart in stride(from: 0, to: message.count, by: 64) {
            let chunk = message.subdata(in: chunkStart..<chunkStart+64)
            var w = [UInt32](repeating: 0, count: 16)
            
            // Break chunk into sixteen 32-bit words
            for i in 0..<16 {
                let start = i * 4
                w[i] = chunk.subdata(in: start..<start+4).withUnsafeBytes { $0.load(as: UInt32.self) }
            }
            
            // Initialize hash value for this chunk
            var a = h[0], b = h[1], c = h[2], d = h[3]
            
            // Main loop
            for i in 0..<64 {
                var f: UInt32 = 0
                var g: Int = 0
                
                switch i {
                case 0...15:
                    f = (b & c) | (~b & d)
                    g = i
                case 16...31:
                    f = (d & b) | (~d & c)
                    g = (5 * i + 1) % 16
                case 32...47:
                    f = b ^ c ^ d
                    g = (3 * i + 5) % 16
                case 48...63:
                    f = c ^ (b | ~d)
                    g = (7 * i) % 16
                default:
                    break
                }
                
                f = f &+ a &+ K[i] &+ w[g]
                a = d
                d = c
                c = b
                b = b &+ leftRotate(f, by: S[i])
            }
            
            // Add this chunk's hash to result
            h[0] = h[0] &+ a
            h[1] = h[1] &+ b
            h[2] = h[2] &+ c
            h[3] = h[3] &+ d
        }
        
        // Convert hash to bytes
        for i in 0..<4 {
            let value = h[i]
            digest[i*4] = UInt8(value & 0xff)
            digest[i*4+1] = UInt8((value >> 8) & 0xff)
            digest[i*4+2] = UInt8((value >> 16) & 0xff)
            digest[i*4+3] = UInt8((value >> 24) & 0xff)
        }
    }
    
    /// Left rotate function for MD5
    private func leftRotate(_ value: UInt32, by amount: UInt32) -> UInt32 {
        return (value << amount) | (value >> (32 - amount))
    }
    #endif
}
