//
//  Pagination.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

struct Pagination<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case data
        case meta
    }

    let data: T
    let meta: PaginationMeta
}

struct PaginationMeta: Codable {
    enum CodingKeys: String, CodingKey {
        case curPage = "cur_page"
        case nextPage = "next_page"
        case pageNum = "page_num"
    }

    let curPage: Int
    let nextPage: Int
    let pageNum: Int
}
