#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -At -c"

# renaming
echo $($PSQL "ALTER TABLE properties RENAME weight TO atomic_mass")
echo $($PSQL "ALTER TABLE properties RENAME melting_point TO melting_point_celsius")
echo $($PSQL "ALTER TABLE properties RENAME boiling_point TO boiling_point_celsius")

# Not Null Constraint
echo $($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL")
echo $($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL")
echo $($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")
echo $($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")

# Unique Constraint
echo $($PSQL "ALTER TABLE elements ADD UNIQUE(symbol)")
echo $($PSQL "ALTER TABLE elements ADD UNIQUE(name)")

# Foreign Key
echo $($PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number)")

# Create Table
echo $($PSQL "CREATE TABLE types(type_id SERIAL PRIMARY KEY, type VARCHAR(30) NOT NULL)")

# Add rows
echo $($PSQL "INSERT INTO types(type) VALUES ('metal'),('metalloid'),('nonmetal')")

# Add columns
echo $($PSQL "ALTER TABLE properties ADD COLUMN type_id INT")
TYPE_RESULT=$($PSQL "SELECT DISTINCT(type) FROM properties")
echo "$TYPE_RESULT" | while read TYPE
do
  TYPE_ID=$($PSQL "SELECT type_id FROM TYPES WHERE type = '$TYPE'")
  TYPE_ID_INSERT=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE type = '$TYPE'")
  echo $TYPE_ID_INSERT
done
echo  $($PSQL "ALTER TABLE properties DROP COLUMN type")
echo $($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL")
echo $($PSQL "ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types(type_id)")

# Capitalize first letter
CAPITALIZE_RESULT=$($PSQL "UPDATE elements SET symbol = CONCAT(UPPER(LEFT(symbol,1)),SUBSTRING(symbol,2,LENGTH(symbol)))")
echo $CAPITALIZE_RESULT

# remove all the trailing zero
echo $($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL")
echo $($PSQL "UPDATE properties SET atomic_mass = TRIM(TRAILING '0' from atomic_mass::text)::DECIMAL")
 
# insert Fluorine
INSERT_F_ELEMENT=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES(9,'F','Fluorine')")
echo $INSERT_F_ELEMENT
INSERT_F_PROPERTIES=$($PSQL "INSERT INTO properties(atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES(9,18.998,-220,-188.1,3)")
echo $INSERT_F_PROPERTIES

# insert Neon
INSERT_NE_ELEMENT=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES(10,'Ne','Neon')")
echo $INSERT_NE_ELEMENT
INSERT_NE_PROPERTIES=$($PSQL "INSERT INTO properties(atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES(10,20.18,-248.6,-246.1,3)")
echo $INSERT_NE_PROPERTIES

# delete atomic_number 1000
echo $($PSQL "DELETE FROM properties WHERE atomic_number = 1000")
echo $($PSQL "DELETE FROM elements WHERE atomic_number = 1000")

# dump db
pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql
