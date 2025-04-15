with calendar as (
    select
        date_day,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(quarter from date_day) as quarter,
        extract(dow from date_day) as weekday,
        case when extract(dow from date_day) in (0,6) then true else false end as is_weekend
    from (
        select dateadd(day, seq4(), '2016-01-01') as date_day
        from table(generator(rowcount => 2000))
    )
)

select * from calendar
where date_day <= current_date
