//
//  UrlPathGeneratable.swift
//  WeatherForecast
//
//  Created by YongHoon JJo on 2021/10/03.
//

import Foundation

protocol UrlGeneratable {
    func generateURL() -> URL?
}