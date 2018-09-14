START TRANSACTION ;

set local search_path = "$user", bookings ;


with
in_flight as (
select 
      flight_id,
      flight_no,
      aircraft_code,
      actual_departure + (scheduled_arrival - scheduled_departure) as planned_arrival
   from flights
   where (actual_departure is not NULL)
        and (actual_arrival is NULL)
),

all_seats as (
select 
       aircraft_code,
       count(*) as seats_count
    from seats
    group by aircraft_code
),
occ_seats as (
select
      flight_id,
      count(*) as occ_seats
   from boarding_passes
   group by flight_id
)

select 
      flt.flight_id,
      flt.flight_no,
      flt.aircraft_code,
      sts.seats_count,
      sts.seats_count - coalesce(occ.occ_seats, 0) as free_seats
   from in_flight as flt
   left outer join all_seats as sts
      on sts.aircraft_code = flt.aircraft_code
   left outer join occ_seats as occ
      on occ.flight_id = flt.flight_id
;


ROLLBACK TRANSACTION ;
-- COMMIT TRANSACTION ;
