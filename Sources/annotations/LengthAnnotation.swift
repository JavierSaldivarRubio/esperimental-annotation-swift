//
//  minLengt.swift
//  experimental_annotation
//
//  Created by Francisco Javier Saldivar Rubio on 31/07/21.
//

import Foundation
@propertyWrapper
public struct MaxLength<Value: StringProtocol>: ASAnnotationWrapped {

    private var value: Value?
    private var maxLength: Int
    public var wrappedValue: Value? {
        get { return self.value }
        set { self.value = self.tranformValue(wrappedValue: newValue) }
    }

    public init(wrappedValue value: Value? = nil, maxLength: Int) {
        self.maxLength = maxLength
        self.wrappedValue = value
    }

    public func tranformValue<T>(wrappedValue: T?) -> T? {
        guard let stringValue = wrappedValue as? Value else {
            return wrappedValue
        }
        return (self.truncate(string: stringValue)) as? T
    }

    private func truncate(string: Value) -> Value? {
        if string.count <= maxLength { // 3
            return string
        }
        return nil
    }
}

@propertyWrapper
public struct MinLength<Value: StringProtocol>: ASAnnotationWrapped {
    private var value: Value?
    private var minLength: Int

    public var wrappedValue: Value? {
        set { self.value = self.tranformValue(wrappedValue: newValue) }
        get { return self.value }
    }

    public init(wrappedValue: Value? = nil, minLength: Int) {
        self.minLength = minLength
        self.wrappedValue = wrappedValue
    }

    public  func tranformValue<T>(wrappedValue: T?) -> T? {
        guard let stringValue = wrappedValue as? Value else {
            return wrappedValue
        }
        return self.truncate(string: stringValue) as? T
    }

    private func truncate(string: Value) -> Value? {
        if string.count >= minLength { // 3
            return string
        }
            return nil
    }
}
