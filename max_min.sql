START TRANSACTION ;

-- set local search_path = "$user", bookings, public ;
create view lates_data as
with
period as (
    select 
        date_trunc('day', bookings.now()) - '1 week'::interval as start,
        date_trunc('day', bookings.now()) as finish
),

times as (
select
      flt.flight_id,
      flt.flight_no,
      flt.departure_airport,
      (flt.actual_departure - flt.scheduled_departure) as lated
   from bookings.flights as flt
   inner join period as p
      on (flt.scheduled_departure >= p.start) and (flt.scheduled_departure < p.finish)
)

select
      departure_airport,
      min(lated) as l_min,
      max(lated) as l_max,
      avg(lated) as l_avg
      
   from times
   group by departure_airport ;

-- ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ;
