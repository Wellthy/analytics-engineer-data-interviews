/* Calculates age in years based on a birthdate. Checks if their birthday for the current calendar year is after the current date.
   If so, subtract a year off (as they haven't turned that age yet). Returns age as an integer. 
 */
{% macro get_age_in_years(birthdate) %}
	CASE WHEN DATEADD(year, DATEDIFF(years, {{ birthdate }}, CURRENT_DATE()), {{birthdate}}) > CURRENT_DATE() 
         THEN DATEDIFF(YEARS, {{ birthdate }}, CURRENT_DATE()) - 1
         ELSE DATEDIFF(YEARS, {{ birthdate }}, CURRENT_DATE())
     END
{% endmacro %}