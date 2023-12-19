//
//  main.swift
//  Practica-Swift
//
//  Created by David Ortega Iglesias on 18/12/23.
//

import Foundation

//Creamos un set con los posibles hoteles
let hotels: Set<String> = ["KameHouse","CapsuleCorp","Namek"]


struct Client {
    let name : String
    let age : Int
    let height : Int
    
    init(name: String, age: Int, height: Int) {
        self.name = name
        self.age = age
        self.height = height
    }
}


struct Reservation{
    let id : Int
    let hotelName : String
    let clientList : [Client]
    let duration : Int
    let price : Double
    let breakfast : Bool
    
    init(id: Int, hotelName: String, clientList: [Client], duration: Int, price: Double, breakfast: Bool) {
        self.id = id
        self.hotelName = hotelName
        self.clientList = clientList
        self.duration = duration
        self.price = price
        self.breakfast = breakfast
    }
}


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
    
    func precioBase(hotelName: String)->Int{
        //Asignamos un precio base a cada  hotel
        var total : Int = 0
        if hotelName == "KameHouse"{
            total = 20
        }else if hotelName == "CapsuleCorp"{
            total = 30
        }else{
            total = 40
        }
        return total
    }
    
    func calculaPrecio(numClientes: Int, precioBase:Int, duration:Int, breakfast:Bool) -> Double{
        //Calculamos el precio de la reserva
        var total : Double = 0.0
        if breakfast{
            total = Double(numClientes * precioBase * duration) * 1.25
        }else{
            total = Double(numClientes * precioBase * duration)
        }
        return total
    }
    
    func addReservation(clientList:[Client], duration: Int, breakfast: Bool) -> Void{
        //Para añadir la reserva, elegimos al azar un hotel, calculamos el precio, asignamos una id(así evitamos duplicados) y lo metemos en el array
        
        let hotelName = hotels.randomElement()!//No entiendo porque el random puede devolver nil
        let price = calculaPrecio(numClientes: clientList.count, precioBase: precioBase(hotelName: hotelName), duration: duration, breakfast: breakfast)
        let reserva = Reservation(id: reservationList.count + 1, hotelName: hotelName, clientList: clientList, duration: duration, price: price, breakfast: breakfast)
        reservationList.append(reserva)
        
    }
    
    func cancelReservation(id:Int)throws->Void{
        //Borramos del array de reservationList con el index (id - 1)
        guard id <= reservationList.count else{
            throw ReservationError.errorReservationNotFound
        }
        reservationList.remove(at: id - 1)
    }
    func listReservation()->Void{
        //Recorremos la lista de reservas y lo imprimimos. Si hay mas de un cliente en la reserva tambien se imprime
        for elem in reservationList{
           for cont in 0...elem.clientList.count-1{
                print("id: \(elem.id), name: \(elem.clientList[cont].name), duration: \(elem.duration), price: \(elem.price), breakfast: \(elem.breakfast), hotel: \(elem.hotelName)")
            }
        }
    }
}

let goku = Client(name: "Goku", age: 37, height: 175)
let bulma = Client(name: "Bulma", age: 41, height: 165)
let vegeta = Client(name: "Vegeta", age: 42, height: 164)

let reserva1 = Reservation(id: 1, hotelName: "KameHouse", clientList: [goku], duration: 3, price: 300, breakfast: true)
let reserva2 = Reservation(id: 2, hotelName: "KameHouse", clientList: [bulma,vegeta], duration: 7, price: 700, breakfast: false)
let reserva3 = Reservation(id: 3, hotelName: "CapsuleCorp", clientList: [bulma], duration: 5, price: 500, breakfast: false)

let manager = HotelReservationManager(reservationList: [])

manager.addReservation(clientList: reserva1.clientList, duration: reserva1.duration, breakfast: reserva1.breakfast)
manager.addReservation(clientList: reserva2.clientList, duration: reserva2.duration, breakfast: reserva2.breakfast)

manager.listReservation()
print("-------")

do{
   try manager.cancelReservation(id: 2)
   try manager.cancelReservation(id: 7)
}catch ReservationError.errorReservationNotFound{
    print("No se encuentra la id para cancelar la reserva")
}

manager.listReservation()
print("-------")
manager.addReservation(clientList: reserva3.clientList, duration: reserva3.duration, breakfast: reserva3.breakfast)

manager.listReservation()
