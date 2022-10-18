/* #Odd and Even Measurements

Assume you are given the table below containing measurement values obtained from a sensor over several days. Measurements are taken several times within a given day.

Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns.

Note that the 1st, 3rd, 5th measurements within a day are considered odd-numbered measurements and the 2nd, 4th, 6th measurements are even-numbered measurements.

measurements Table:
Column Name	Type
measurement_id	integer
measurement_value	decimal
measurement_time	datetime

measurements Example Input:
measurement_id	measurement_value	measurement_time
131233	1109.51	07/10/2022 09:00:00
135211	1662.74	07/10/2022 11:00:00
523542	1246.24	07/10/2022 13:15:00
143562	1124.50	07/11/2022 15:00:00
346462	1234.14	07/11/2022 16:45:00

Example Output:
measurement_day	odd_sum	even_sum
07/10/2022 00:00:00	2355.75	1662.74
07/11/2022 00:00:00	1124.50	1234.14

Explanation
On 07/11/2022, there are only two measurements. In chronological order, the first measurement (odd-numbered) is 1124.50, and the second measurement(even-numbered) is 1234.14.
 */
--Solution

with t AS
(SELECT measurement_id,
       measurement_value,
       measurement_time,
       row_number() over (PARTITION BY date(measurement_time) ORDER BY measurement_time asc) as num FROM measurements
)

SELECT date(t.measurement_time) as measurement_day,
       sum(case when t.num = 1 or t.num= 3 or t.num= 5
            then t.measurement_value 
        end ) as odd_sum,
        sum(case when t.num = 2 or t.num= 4 or t.num= 6
            then (t.measurement_value)
        end) as even_sum
FROM t
GROUP BY date(t.measurement_time)
ORDER BY 1
;