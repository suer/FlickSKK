//
//  ViewController.swift
//  FlickSKK
//
//  Created by BAN Jun on 2014/09/27.
//  Copyright (c) 2014年 BAN Jun. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {
    var sections : [(title: String?, rows: [(title: String, action: Void -> Void)])]!

    convenience override init() {
        self.init(style: .Grouped)
    }

    override init(nibName: String?, bundle: NSBundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }

    override init(style: UITableViewStyle) {
        super.init(style: style)

        weak var weakSelf = self
        sections = [
            (title: nil, rows: [(title: NSLocalizedString("Setup", comment: ""), action: { weakSelf?.gotoSetup(); return})]),
            (title: nil, rows: [(title: NSLocalizedString("How to use", comment: ""), action: { weakSelf?.gotoHowToUse(); return})]),
            // FIXME: 設定項目をなんか増やす
            // (title: nil, rows: [(title: NSLocalizedString("Settings", comment: ""), action: { weakSelf?.gotoSettings(); return})]),
            (title: nil, rows: [(title: NSLocalizedString("User Dictionary", comment: ""), action: { weakSelf?.gotoUserDictionary(); return})]),
            (title: nil, rows: [(title: NSLocalizedString("License", comment: ""), action: { weakSelf?.gotoLicense(); return})]),
        ]
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("FlickSKK", comment: "")
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    let kCellID = "Cell"

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID) as? UITableViewCell ?? UITableViewCell(style: .Default, reuseIdentifier: kCellID)
        let row = sections[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = row.title
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = sections[indexPath.section].rows[indexPath.row]
        row.action()
    }

    // MARK: - Actions
    func gotoSetup() {
        if let path = NSBundle.mainBundle().pathForResource("Setup", ofType: "html", inDirectory: "html") {
            navigationController?.pushViewController(WebViewController(URL: NSURL(fileURLWithPath: path)!), animated: true)
        }
    }


    func gotoHowToUse() {
        if let path = NSBundle.mainBundle().pathForResource("HowToUse", ofType: "html", inDirectory: "html") {
            navigationController?.pushViewController(WebViewController(URL: NSURL(fileURLWithPath: path)!), animated: true)
        }
    }

    func gotoSettings() {

    }

    func gotoUserDictionary() {
        navigationController?.pushViewController(UserDictionaryViewController(), animated: true)
    }

    func gotoLicense() {
        if let path = NSBundle.mainBundle().pathForResource("License", ofType: "html", inDirectory: "html") {
            navigationController?.pushViewController(WebViewController(URL: NSURL(fileURLWithPath: path)!), animated: true)
        }
    }

    // MARK: -

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

