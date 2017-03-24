view: country {
  sql_table_name: sakila.country ;;

  dimension: country_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.country_id ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_update ;;
  }

  measure: count {
    type: count
    drill_fields: [country_id, city.count]
  }
}
