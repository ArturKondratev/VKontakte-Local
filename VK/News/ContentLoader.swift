//
//  ContentLoader.swift
//  VK
//
//  Created by Артур Кондратьев on 25.02.2022.
//

import Foundation

class ContentLoader {
    
    static func needcontent() -> [NewsModel] {
        return [ NewsModel(avatar: "1-1",
                           nameOfNews: "Интересные факты",
                           dateNews: "Сегодня в 17:19",
                           textNews: "Эверест — самая высокая точка планеты, высота — 8848 метров. Гора входит в горную систему Гималаи и лежит аккурат на границе между Китаем (северный склон) и Непалом (южный склон), благодаря чему совершить восхождение можно сразу из двух стран, на выбор.",
                           imageNews: "1-2"),
                 NewsModel(avatar: "2-1",
                           nameOfNews: "National Geographic",
                           dateNews: "Сегодны в 12:00",
                           textNews: "Ученые США выяснили, что пумы - важнейшие животные в Америке — они так хорошо охотятся, что каждый день оставляют около 1,5 МЛН килограммов добычи, которые благоприятно влияют на экосистему и кормят других животных, которые по тем или иным причинам, не могут охотиться самостоятельно.",
                           imageNews: "2-2"),
                 NewsModel(avatar: "2-1",
                           nameOfNews: "National Geographic",
                           dateNews: "Вчера в 13:25",
                           textNews: "Байкал",
                           imageNews: "3-3")
                 
        ]
    }
}



