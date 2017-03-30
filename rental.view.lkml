view: rental {
  sql_table_name: sakila.rental ;;

  dimension: rental_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.rental_id ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: inventory_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_id ;;
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

  dimension_group: rental {
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
    sql: ${TABLE}.rental_date ;;
  }

  dimension_group: due_date {
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
    sql: date_add(${rental_date}, INTERVAL 10 DAY) ;;
  }

  dimension_group: return {
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
    sql: ${TABLE}.return_date ;;
  }

  dimension: days_out_for_rent {
    type: number
    sql: datediff(${return_date}, ${rental_date}) ;;
  }

  dimension: out_for_rent {
    type: yesno
    sql: isnull(${return_date}) ;;
  }

  dimension: overdue {
    type: yesno
    sql: (COALESCE(return_date, CURDATE()))>${due_date_date} ;;
  }

  dimension: staff_id {
    type: yesno
    # hidden: yes
    sql: ${TABLE}.staff_id ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      rental_id,
      inventory.inventory_id,
      customer.customer_id,
      customer.first_name,
      customer.last_name,
      staff.staff_id,
      staff.first_name,
      staff.last_name,
      staff.username,
      payment.count
    ]
  }
}
