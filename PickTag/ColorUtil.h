//
//  ColorUtil.h
//  NewPipe
//
//  Created by Somiya on 2018/10/15.
//  Copyright © 2018 Somiya. All rights reserved.
//

#ifndef ColorUtil_h
#define ColorUtil_h
// 十六进制转十进制
#define UICOLOR_HEX(hexString) [UIColor colorWithRed:((float)((hexString &0xFF0000) >>16))/255.0 green:((float)((hexString &0xFF00) >>8))/255.0 blue:((float)(hexString &0xFF))/255.0 alpha:1.0]
// RGBA
#define UICOLOR_RGB(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// 随机颜色
#define UICOLOR_RANDOM [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]

#endif /* ColorUtil_h */
