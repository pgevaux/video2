connection: "video_store"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: rental {
  join: inventory {
    type: left_outer
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: staff {
    type: left_outer
    sql_on: ${rental.staff_id} = ${staff.staff_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${store.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

  join: film_category {
    type: left_outer
    sql_on: ${film.film_id}=${film_category.film_id} ;;
    relationship: many_to_one
  }

  join: category {
    type: left_outer
    sql_on: ${film_category.category_id}=${category.category_id} ;;
    relationship: many_to_one
  }
}
