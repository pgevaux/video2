view: sales_by_film_category {
  sql_table_name: sakila.sales_by_film_category ;;

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: total_sales {
    type: number
    sql: ${TABLE}.total_sales ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
