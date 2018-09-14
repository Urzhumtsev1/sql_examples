START TRANSACTION ;

set local search_path = "$user", bookings ;

with st_count as (
select 
    aircraft_code,
    count(*) as seats_count
    from seats
    group by aircraft_code
)

select
      ac.aircraft_code,
      ac.model,
      st.seats_count
   from aircrafts as ac
   inner join st_count as st
      on ac.aircraft_code = st.aircraft_code ;
      

ROLLBACK TRANSACTION ;
-- COMMIT TRANSACTION ;
