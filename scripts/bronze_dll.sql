/*
===========================
bronze_card_load
Purpose: Truncate + Insert all JSON File data into the bronze layer.
-- Gathers Data on all 1000 pokemon, grouped by simple attributes, array attributes, and object attributes.
===============================

*/
IF OBJECT_ID('bronze.cards_json_raw','U') IS NOT NULL
	DROP TABLE bronze.cards_json_raw

SELECT * 
INTO bronze.cards_json_raw
FROM OPENROWSET(BULK 'C:\live_data_pokemon\pokemon_data\pokemon_cards_20260108.json', SINGLE_CLOB) as sample_data
CROSS APPLY OPENJSON(BulkColumn)
			WITH(
			--Simple attributes -- information is not enclosed
			id NVARCHAR(50),
			name NVARCHAR(255),
			supertype			NVARCHAR(255),
			hp					INT,
			evolves_from		NVARCHAR(255) '$.evolvesFrom',
			converted_retreat_cost INT '$.convertedRetreatCost',
			number				NVARCHAR(MAX),
			artist				NVARCHAR(255),
			rarity				NVARCHAR(255),
			flavor_test			NVARCHAR(MAX) '$.flavorTest',

			--Arrays -- information is in []
			subtypes			NVARCHAR(MAX) AS JSON,
			types				NVARCHAR(MAX) AS JSON,
			attacks				NVARCHAR(MAX) AS JSON,
			weaknesses			NVARCHAR(MAX) AS JSON,
			resistances			NVARCHAR(MAX) AS JSON,
			retreat_cost		NVARCHAR(MAX) '$.retreatCost' AS JSON,
			national_pokedex_numbers NVARCHAR(MAX) '$.nationalPokedexNumbers' AS JSON,

			
			--Objects -- information is in {}
			[set]				NVARCHAR(MAX) AS JSON,
			legalities			NVARCHAR(MAX) AS JSON,
			images				NVARCHAR(MAX) AS JSON,
			tcgplayer			NVARCHAR(MAX) AS JSON,
			cardmarket			NVARCHAR(MAX) AS JSON
			)


--SELECT * FROM bronze.cards_json_raw



--=====================================
--======================================



--Insert Data example--

--example
/*
SELECT *
FROM OPENROWSET(BULK 'C:\live_data_pokemon\scripts\json example data.json', SINGLE_CLOB) as J
CROSS APPLY OPENJSON(BulkColumn)
WITH 
(
id NVARCHAR(50),
name NVARCHAR(255),
supertype NVARCHAR(50)
) as pokemon
*/
/*
DECLARE @today NVARCHAR(8) = FORMAT(GETDATE(),'yyyymmdd');
DECLARE @file_path NVARCHAR(255) = CONCAT('C:\live_data_pokemon\pokemon_data\pokemon_cards_',@today,'.json');
DECLARE @sql_extract_todays_cards NVARCHAR(MAX);
DECLARE @list_of_attributes NVARCHAR(MAX);
*/


--SELECT * from bronze.cards_test

-- AUTOMATION (for LATER)
/*
--DYNAMIC date card extraction into bronze layer
SET @sql_extract_todays_cards = 'SELECT * 
FROM OPENROWSET(BULK '+@today+', SINGLE_CLOB) as sample_data
CROSS APPLY OPENJSON(BulkColumn)
			WITH(
			
			)'

-- EXEC sp_executesql @sql; -- this will execute the string (@sql variable) as it is.


*/


