//
//  Mutex.swift
//  AgileEngine
//
//  Created by Oleksandr Deundiak on 03.06.2020.
//  Copyright © 2020 Oleksandr Deundiak. All rights reserved.
//

import Foundation

enum MutexError: Error {
    case unknownError(pthreadErrorCode: Int32)
}


class Mutex {
    private var mutex = pthread_mutex_t()

    init() {
        pthread_mutex_init(&self.mutex, nil)
    }

    deinit {
        pthread_mutex_destroy(&self.mutex)
    }

    func lock() throws {
        let result = pthread_mutex_lock(&self.mutex)

        guard result == 0 else {
            throw MutexError.unknownError(pthreadErrorCode: result)
        }
    }

    func unlock() throws {
        let result = pthread_mutex_unlock(&self.mutex)

        guard result == 0 else {
            throw MutexError.unknownError(pthreadErrorCode: result)
        }
    }

    func executeSync(closure: () -> Void) throws {
        try self.lock()

        closure()

        try self.unlock()
    }

    func executeSync(closure: () throws -> Void) throws {
        try self.lock()

        do {
            try closure()
        }
        catch {
            try self.unlock()
            throw error
        }

        try self.unlock()
    }
}
