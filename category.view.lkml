view: category {
  sql_table_name: sakila.category ;;

  dimension: category_id {
    primary_key: yes
    hidden: yes
    type: yesno
    sql: ${TABLE}.category_id ;;
  }

  dimension_group: last_update {
    hidden: yes
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

  dimension: name {
    view_label: "Film"
    label: "Genre"
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: genre_count {
    view_label: "Film"
    type: count
    drill_fields: [category_id, name, film_category.count]
  }
}
