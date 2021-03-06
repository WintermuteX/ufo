view: average_locations_by_shape {

  view_label: "Average Location By Shape"

  derived_table: {
    sql: SELECT
        shape,
        AVG(latitude) AS "aver_latitude",
        AVG(longitude) AS "aver_longitude"
      FROM
        public.ufo_data
      GROUP BY
        shape;;
    persist_for: "24 hours"
    indexes: ["shape"]
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: shape {
    primary_key: yes
    type: string
    sql: ${TABLE}.shape ;;
  }

  dimension: aver_latitude {
    type: string
    sql: ${TABLE}.aver_latitude ;;
  }

  dimension: aver_longitude {
    type: string
    sql: ${TABLE}.aver_longitude ;;
  }

  dimension: avg_location {
    type: location
    sql_latitude: ${TABLE}.aver_latitude ;;
    sql_longitude:${TABLE}.aver_longitude;;
  }

  set: detail {
    fields: [shape, aver_latitude, aver_longitude]
  }
}
