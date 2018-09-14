START TRANSACTION ;

create schema if not exists mymodel ;

create table mymodel.flights (
   flight_id bigserial not null primary key,
   flight_no text not null,
   scheduled_departure timestamp,
   scheduled_arrival timestamp,
   departure_airport char(3) not null,
   arrival_airport char(3) not null,
   actual_departure timestamp,
   actual_arrival timestamp
) ;

create table mymodel.ticket_flights (
   ticket_no varchar(30) not null,
   flight_id bigint not null references mymodel.flight(flight_id),
   fare_conditions text,
   amount int,
   constraint ticket_flights_pkey primary key (ticket_no, flight_id)
) ;

create table mymodel.boarding_passes (
   ticket_no varchar(30) not null,
   flight_id bigint not null,
   boarding_no int not null,
   seat_no text not null,
   constraint boarding_passes_pkey primary key (ticket_no, flight_id ),
   constraint passeing_passes_fkey
      foreign key (ticket_no, flight_id)
      references mymodel.ticket_flights(ticket_no, flight_id)
) ;


/*create table mymodel.airports (
   airport_code char(3) not null primary key,
   airport_name text not null,
   
) ;*/

ROLLBACK TRANSACTION ;
