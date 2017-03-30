view: times_rented {
    derived_table: {
      persist_for: "24 hours"
      indexes: ["inventory_id"]
      sql: SELECT
        inventory.inventory_id  AS inventory_id,
        inventory.film_id  AS film_id,
        film.description AS film_name,
        store.store_id as store_id,
        customer.customer_id AS customer_id,
        customer.first_name AS first_name,
        customer.last_name AS last_name,
        customer.email AS email,
        COUNT(inventory.inventory_id) AS rental_count,
        COUNT(return_date) as return_date

      FROM sakila.inventory  AS inventory
      LEFT JOIN sakila.rental  AS rental ON inventory.inventory_id = rental.inventory_id
      LEFT JOIN sakila.film AS film ON inventory.film_id = film.film_id
      LEFT JOIN sakila.store AS store ON inventory.store_id = store.store_id
      LEFT JOIN sakila.customer AS customer ON rental.customer_id = customer.customer_id

      GROUP BY 1,2,3,4,5,6,7
 ;;
    }

    measure: inventory_count {
      type: count
      drill_fields: [detail*]
    }

    dimension: inventory_id {
      primary_key: yes
      type: number
      sql: ${TABLE}.inventory_id ;;
    }

    dimension: film_id {
      type: number
      sql: ${TABLE}.film_id ;;
    }

    dimension: film_name {
      type: string
      sql: ${TABLE}.film_name ;;
    }

    dimension: store_id {
      hidden: yes
      type: yesno
      sql: ${TABLE}.store_id ;;
    }

    dimension: rental_count {
      type: number
      sql: ${TABLE}.`rental_count` ;;
    }

    dimension: return_count {
      type: number
      sql: ${TABLE}.return_date ;;
    }

    dimension: out_for_rent {
    type: yesno
    sql: ${rental_count}-${return_count}>0  ;;
    }

  measure: inventory_out_for_rent {
    type: count_distinct
    sql: ${inventory_id} ;;
    filters: {
      field: out_for_rent
      value: "yes"
    }
    drill_fields: [inventory_id, film_name, first_name, last_name, customer_email]
  }

  measure: inventory_in_stock {
    type: number
    sql: ${inventory_count}-${inventory_out_for_rent} ;;
    value_format_name: decimal_0
  }

  measure: percentage_of_inventory_in_stock {
    type: number
    value_format_name: percent_0
    sql: 1.0*${inventory_in_stock}/${inventory_count} ;;
    html: {% if value > 0.90 %}
          <div style="color: green">{{ rendered_value }}</div>
          {% elsif value > 0.80 %}
          <div style="color: orange">{{ rendered_value }}</div>
          {% else %}
          <div style="color: red">{{ rendered_value }}</div>
          {% endif %}
          ;;
  }


  dimension: first_name {
    hidden: no
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    hidden: no
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: customer_name {
    hidden: yes
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.email ;;
  }

    set: detail {
      fields: [
        inventory_id,
        film_id,
        film_name,
        store_id,
        rental_count,
        return_count
      ]
    }
  }
