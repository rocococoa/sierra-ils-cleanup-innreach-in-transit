/* Retrieves a list of items that have been in-transit from a Link+ library (INN-Reach library) for over 30 days, includes bib-level hold count 
	Created AGW 3/2026 */

WITH hold_counts AS (
    SELECT
        h.record_id AS bib_record_id,
        COUNT(h.id) AS hold_count
    FROM
        sierra_view.hold h
    GROUP BY
        h.record_id
)

SELECT
    DISTINCT i.location_code AS "Location",
    CASE
        WHEN pei.index_entry IS NULL THEN UPPER(peb.index_entry)
        ELSE UPPER(pei.index_entry)
    END AS "Call#",
    brp.best_author AS "Author",
    brp.best_title AS "Title",
    i.barcode AS "Barcode",
	COALESCE(hc.hold_count, 0) AS "Holds",
	'b' || rmb.record_num || 'a' AS "Bib Record Num",
	v.field_content
    
    
FROM
    sierra_view.item_view i
JOIN sierra_view.record_metadata rmi ON rmi.id = i.id AND rmi.record_type_code = 'i'
JOIN sierra_view.bib_record_item_record_link bri ON bri.item_record_id = i.id
JOIN sierra_view.record_metadata rmb ON rmb.id = bri.bib_record_id AND rmb.record_type_code = 'b'
JOIN sierra_view.phrase_entry peb ON peb.record_id = bri.bib_record_id AND peb.index_tag = 'c'
LEFT JOIN sierra_view.phrase_entry pei ON pei.record_id = i.id AND pei.index_tag = 'c'
JOIN sierra_view.bib_record_property brp ON brp.bib_record_id = bri.bib_record_id
LEFT JOIN sierra_view.checkout c ON c.item_record_id=i.id
LEFT JOIN sierra_view.varfield_view v ON v.record_id=i.id
LEFT JOIN hold_counts hc ON hc.bib_record_id = bri.bib_record_id
WHERE
    i.item_status_code = '@'
	AND v.field_content LIKE '%IN TRANSIT%'
    AND rmi.record_last_updated_gmt::date <=now()- interval '30 days'

ORDER BY
    i.location_code,
    "Call#",
    brp.best_author,
    brp.best_title;