--------------------------------------------------------------
/*		            Index Definition in SQL                 */
--------------------------------------------------------------

--  Index Motivation

    /*  Consider the following queries that only access a small portion
        of the records in a file/table.

        -- Query: "Find all instructors in the Physics department."

        SELECT *
        FROM instructor
        WHERE dept_name = 'Physics';

        -- Query: "Find the salary of the instructor with ID 22201."

        SELECT salary
        FROM instrcutor
        WHERE ID = '22201';

    /*  An index on an attribute of a relation is a data structure that allows
        the database system to find those tuples in the relation that have a
        specified value for that attribute efficiently, without scanning through
        all the tuples of the relation.     */

--  Index Definition

    /*
        General Syntax:
        CREATE INDEX <indexName> ON <relationName> (<attList>);
    */

    /*  Task: Define an index named dept_index on the instructor relation
        with dept_name as the search key.   */
			
CREATE INDEX dept_index ON instructor (dept_name);


--  Dropping an Index

        -- General Form: DROP INDEX <indexName>

        DROP INDEX dept_index;














