view: film_actor {
  sql_table_name: sakila.film_actor ;;

  dimension: actor_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.actor_id ;;
  }

  dimension: film_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.film_id ;;
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
    drill_fields: [actor.actor_id, actor.first_name, actor.last_name, film.film_id]
  }
}
