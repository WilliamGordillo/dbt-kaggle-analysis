{% macro get_duration_minutes(start_time, end_time) %}
   date_trunc('second',{{ end_time }} - {{ start_time }})
{% endmacro %}