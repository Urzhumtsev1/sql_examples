START TRANSACTION ;

set local search_path = "$user", bookings, public ;

select 
      flt.flight_id,
      flt.flight_no,
      flt.departure_airport,
      flt.arrival_airport,
      flt.scheduled_departure,
      flt.scheduled_arrival,
      flt.actual_departure,
      flt.actual_arrival
   from flights as flt
   where date_trunc('day', bookings.now()) = date_trunc('day', flt.scheduled_departure)  
      
;

ROLLBACK TRANSACTION ;
-- COMMIT TRANSACTION ;
