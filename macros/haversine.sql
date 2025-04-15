{% macro haversine(lat1, lng1, lat2, lng2) %}
    6371 * acos(
        LEAST(
            GREATEST(
                cos(radians({{ lat1 }})) * cos(radians({{ lat2 }})) *
                cos(radians({{ lng2 }}) - radians({{ lng1 }})) +
                sin(radians({{ lat1 }})) * sin(radians({{ lat2 }})),
                -1
            ),
            1
        )
    )
{% endmacro %}