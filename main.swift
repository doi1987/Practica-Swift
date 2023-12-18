//
//  main.swift
//  Practica-Swift
//
//  Created by David Ortega Iglesias on 18/12/23.
//

import Foundation

struct Client {
    private let name : String
    private let age : Int
    private let height : Int
    
    init(name: String, age: Int, height: Int) {
        self.name = name
        self.age = age
        self.height = height
    }
}

let goku = Client(name: "Goku", age: 37, height: 175)
print(goku)

struct Reservation{
    private let id : Int
    private let hotelName : String
    private let clientList : [Client]
    private let duration : Int
    private let price : Double
    private let breakfast : Bool
    
    init(id: Int, hotelName: String, clientList: [Client], duration: Int, price: Double, breakfast: Bool) {
        self.id = id
        self.hotelName = hotelName
        self.clientList = clientList
        self.duration = duration
        self.price = price
        self.breakfast = breakfast
    }
}

let reserva1 = Reservation(id: 0001, hotelName: "KameHouse", clientList: [goku], duration: 3, price: 300, breakfast: true)
print(reserva1)

enum ReservationError : Error {
    case errorSameId
    case errorReservationAlreadyExists
    case errorReservationNotFound
}

class HotelReservationManager {
    var reservationList : [Reservation]
    
    init(reservationList: [Reservation]) {
        self.reservationList = reservationList
    }
    
    func calculaPrecio(numClientes: Int, precioBase:Int, duration:Int, breakfast:Bool) -> Double{
        var total : Double = 0.0
        if breakfast{
            total = Double(numClientes * precioBase * duration) * 1.25
        }else{
            total = Double(numClientes * precioBase * duration)
        }
        return total
    }
    
    func addReservation(clientList:[Client], duration: Int, breakfast: Bool, id: Int) {
        let hotelName = "KameHouse"
        let price = calculaPrecio(numClientes: clientList.count, precioBase: 20, duration: duration, breakfast: breakfast)
        let reserva = Reservation(id: reservationList.count + 1, hotelName: hotelName, clientList: clientList, duration: duration, price: price, breakfast: breakfast)
        reservationList.append(reserva)
        
    }
    
    func cancelReservation(id:Int){
        
    }
    
    func listReservation(reservationList:[Reservation]){
        for elem in reservationList{
            print(elem)
        }
    }
}




