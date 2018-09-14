START TRANSACTION ;

set local search_path = "$user", bookings ;

EXPLAIN
select 
       --flt.flight_id,
       --msk.airport_code,
       --spb.airport_code
       count(*) as flt_count
    from airports as msk
    inner join flights as flt
       on flt.departure_airport = msk.airport_code
    inner join airports as spb
       on flt.arrival_airport = spb.airport_code
    where (msk.city = 'Москва')
       and (spb.city = 'Санкт-Петербург')

;
ROLLBACK TRANSACTION ;
-- COMMIT TRANSACTION ;
