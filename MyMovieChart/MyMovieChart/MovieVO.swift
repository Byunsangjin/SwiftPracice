//
//  MovieVO.swift
//  MyMovieChart
//
//  Created by sjbyun on 2018. 8. 7..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import Foundation
import UIKit

class MovieVO {
    var thumbnail: String? // 영화 썸네일 이미지 주소
    var title: String? // 영화 제목
    var description: String? // 영화 설명
    var detail: String? // 상세 정보
    var opendate: String? // 개봉일
    var rating: Double? // 평점
    
    // 영화 썸네일 이미지를 담을 UIImage 객체를 추가한다.
    var thumbnailImage: UIImage?
}
