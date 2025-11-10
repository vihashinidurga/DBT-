{% macro clean_price(col) %}
 NULLIF(regexp_replace({{ col }}, '[^0-9\.]',''),'')::FLOAT
{% endmacro %}

{% macro to_bool(col)%}
case
  when lower(trim({{ col }})) in ('t','true','1','y','yes') then true
  when lower(trim({{ col }})) in ('f','false','0','n','no') then false
  else null 
end  
{% endmacro%}