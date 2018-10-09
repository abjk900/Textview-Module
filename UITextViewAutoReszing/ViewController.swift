//
//  ViewController.swift
//  UITextViewAutoReszing
//
//  Created by NIA on 2018. 10. 8..
//  Copyright © 2018년 NIA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    //UITextView
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        textView.isScrollEnabled = false
        textView.text = "Placeholder"
        textView.textColor = UIColor.white
        textView.becomeFirstResponder()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        textView.delegate = self
        
    }
    
    //Textview autoresizing depend on contents size
    //텍스트 컨텐츠에 따라 높이가 조절되도록
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    //Making textView Placeholder and limited charetes thing
    //텍스트뷰 Placeholder 와 텍스트뷰 글씨제한.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //텍스트뷰에 텍스트가 입력, 텍스트의 범위 추적, 텍스트 캐릭터 수
        let currentText = textView.text
        let updatedText = (currentText! as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = updatedText.count
        
        //텍스뷰가 비어있으면 "textView.text = "Placeholder""
        if updatedText.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.white
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        //텍스트뷰가 에 Placeholder 의 색이 화이트 이고, 텍스트뷰가 비어 있지 않으면 텍스트 칼러는 블랙
        else if textView.textColor == UIColor.white && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
            
        // For every other case, the text should change with the usual
        else {
            return true && numberOfChars < 10
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }

}

