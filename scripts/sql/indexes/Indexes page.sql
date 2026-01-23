/*
		INDEXES PAGE
*/


CREATE CLUSTERED INDEX ix_bronze_clustered ON bronze.cards_json_raw (id)
CREATE INDEX IX_Bronze_Evolution_Lookup ON bronze.cards_json_raw (name, evolves_from);


exec sp_helpindex 'bronze.cards_json_raw'