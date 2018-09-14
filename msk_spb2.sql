START TRANSACTION ;

set local search_path = "$user", bookings ;

/*
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
*/

with 
moscow as (
   select airport_code
      from airports
      where city = 'Москва'
),
saintpet as (
   select airport_code
      from airports
      where city = 'Санкт-Петербург'
)
select 
      count (*) as flights_count
   from flights as flt
   inner join moscow as msk on msk.airport_code = flt.departure_airport
   inner join saintpet as spb on spb.airport_code = flt.arrival_airport
;

ROLLBACK TRANSACTION ;
-- COMMIT TRANSACTION ;
