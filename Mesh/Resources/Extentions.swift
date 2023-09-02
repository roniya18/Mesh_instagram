//
//  Extentions.swift
//  Mesh
//
//  Created by alkesh s on 31/08/23.
//

import UIKit

extension UIView{
    
    public var width : CGFloat{
        return frame.size.width
    }
    
    public var height : CGFloat{
        return frame.size.height
    }
    
    public var top : CGFloat{
        return frame.origin.y
    }
    
    public var bottom : CGFloat{
        return frame.origin.y + height
    }
    
    public var left : CGFloat{
        return frame.origin.x
    }
    
    public var right : CGFloat{
        return frame.origin.x + width
    }
}

extension String{
    public func safeKey() -> String{
        return self.replacing("@", with: "-").replacing(".", with: "-")
        
    }
}
