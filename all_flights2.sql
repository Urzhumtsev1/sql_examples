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
      flt.actual_arrival,
      flt.status,
      flt.actual_departure + (flt.scheduled_arrival - flt.scheduled_departure) as planned_arrival
   from flights as flt
   where (flt.actual_departure is not NULL)
        and (flt.actual_arrival is NULL)
;

ROLLBACK TRANSACTION ;
-- COMMIT TRANSACTION ;
