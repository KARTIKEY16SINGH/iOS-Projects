//
//  LowLevelDesign.swift
//  BookMyShow
//
//  Created by Iron Man on 13/03/22.
//

import UIKit

struct Cinema {
    let id: UUID
    let name: String
    let address: Address
    let audis: [Audi]
}

struct Address {
    let addressLine1: String
    let addressLine2: String
    let city: String
    let state: String
    let pincode: Int
}

struct Audi {
    let id: UUID
    let name: String
    let totalSears: Int
    let audiType: AudiType
    let shows: [Show]
}

enum AudiType {
    case twoD
    case threeD
    case fourD
}

struct Show {
    let id: UUID
    let movie: Movie
    let showTime: ShowTime
    let showStatus: ShowStatus
    let showSeatStatus: ShowSeatStatus
    let bookeadSeats: [Seat]
}

enum ShowSeatStatus {
    case houseFull
    case notFilled
}

struct Movie {
    let id: UUID
    let title: String
    let description: String
    let actors: [String]
    let poster: String
    let show: [Show]?
}

struct ShowTime {
    let startTime: Date
    let endTime: Date
}

enum ShowStatus {
    case inProgress
    case completed
    case scheduled
}

struct Seat {
    let id: UUID
    let seatNo: Int
    let status: SeatStatus
    let price: Double
    let seatType: SeatType
}

enum SeatStatus {
    case reserved
    case notReserved
}

enum SeatType {
    case regular
    case premium
    case delux
    case vip
}

struct Booking {
    let id: UUID
    let show: Show
    let seats: [Seat]
    let status: BookingStatus
    let ticket: Ticket
}

enum BookingStatus {
    case booked
    case notBooked
    case cancled
}

struct Ticket {
    let id: UUID
    let user: User
    let paymentDetails: Payment
    let amount: Double
}

struct User {
    let id: UUID
    let name: String
    let email: String
    let password: String
}

struct Payment {
    let user: String
    let paymentType: PaymentType
    let paymentStatus: PaymentStatus
}

enum PaymentType {
    case cod
    case cardPayment(cardNumber: Int, cvc: Int, expiryMonth: Int, expiryYear: Int)
    case netBanking(bankName: String)
}

enum PaymentStatus {
    case successful
    case failed
    case declined
    case notInitiated
}

protocol MovieSearchProtocol {
    func searchMovieByTitle(title: String) -> [Movie]
    func searchMovieByCity(city: String) -> [Movie]
    func searchMovieByLanguage(language: String) -> [Movie]
    func searchMovieByDate(date: Date) -> [Movie]
    func searchCinemaForCity(city: String) -> [Cinema]
}

//class SearchManager: MovieSearchProtocol {}

// DataModel for Views


class MainScreenVC {
    @IBAction func search() {}
    
    func navigateToCinema(){}
    func navigateToMovies(){}
}

struct MainViewModel {
    var searchDelegate: MovieSearchProtocol
    func searchMovie(title: String?, city: String?, lang: String?) {}
    
    func showMovieList() {}
    func showCinemas() {}
}

class MovieListVC {
    var dataSource: [MovieModal]?
}

protocol BasicMovieProctol {
    id
    poster
    title
}
struct MovieModal {
    let id: UUID
    let poster: String
    let title: String
}
