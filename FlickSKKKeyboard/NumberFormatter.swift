//
//  NumberFormatter.swift
//  FlickSKK
//
//  Created by MIZUNO Hiroki on 12/27/14.
//  Copyright (c) 2014 BAN Jun. All rights reserved.
//

class NumberFormatter {
    let value : Int
    init(value : Int) {
        self.value = value
    }

    func asAscii() -> String {
        return NSString(format: "%d", self.value)
    }

    func asFullWidth() -> String {
        return conv(asAscii(), from: "0123456789", to: "０１２３４５６７８９")
    }

    func asJapanese() -> String {
        return conv(asAscii(), from: "0123456789", to: "〇一二三四五六七八九")
    }

    func asKanji() -> String {
        if value == 0 {
            return "零"
        } else {
            return toKanji(value)
        }
    }

    private func conv(target : String, from : String, to : String) -> String {
        return implode(Array(target).map( { c in
            tr(c, from, to) ?? c
        }))
    }


    private func toKanji_lt_10(n : Int) -> String? {
        // where n < 10
        if n == 0 {
            return .None
        } else if n == 1 {
            return ""
        } else {
            let xs = Array("__二三四五六七八九")
            return String(xs[n])
        }
    }

    private func toKanjiDigit(n : Int, at : Int, name: String) -> String {
        return toKanji_lt_10((n / at) % 10).map({ c in c + name }) ?? ""
    }

    private func toKanji_lt_10000(n : Int) -> String? { // where n < 10_000
        if n == 0 {
            return .None
        } else if n == 1 {
            return "一"
        } else {
            let _1000 = toKanjiDigit(n, at: 1000, name: "千")
            let _100 = toKanjiDigit(n, at: 100, name: "百")
            let _10 = toKanjiDigit(n, at: 10, name: "十")
            let _1 = toKanjiDigit(n, at: 1, name: "")
            return _1000 + _100 + _10 + _1
        }
    }

    private func toKanjiDigits(n : Int, at : Int, name: String) -> String {
        return toKanji_lt_10000((n / at) % 1_0000).map({ c in c + name }) ?? ""
    }

    private func toKanji(n : Int) -> String {
        let 兆 = toKanjiDigits(n, at: 1_0000_0000_0000, name: "兆")
        let 億 = toKanjiDigits(n, at: 1_0000_0000, name: "億")
        let 万 = toKanjiDigits(n, at: 1_0000, name: "万")
        let rest = toKanjiDigits(n, at: 1, name: "")

        return 兆 + 億 + 万 + rest
    }
}
