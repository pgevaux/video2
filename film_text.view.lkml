view: film_text {
  sql_table_name: sakila.film_text ;;

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: film_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.film_id ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: [film.film_id]
  }
}
