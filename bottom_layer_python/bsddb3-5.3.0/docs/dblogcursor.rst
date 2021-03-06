.. $Id: dblogcursor.rst,v 337846be2a21 2010/09/17 14:26:06 jcea $

===========
DBLogCursor
===========

Read `Oracle documentation
<http://download.oracle.com/docs/cd/E17076_02/html/programmer_reference/index.html>`__
for better understanding.

`More info...
<http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
C/logc.html>`__

DBLogCursor Methods
-------------------

.. function:: close()

   Discards the log cursor.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcclose.html>`__

DBLogCursor Get Methods
-----------------------

These DBLogCursor methods are all wrappers around the get() function in
the C API.

These functions returns a tuple. The first element is a LSN tuple,
and the second element is a string/bytes with the log data.

If the following methods don't have log data to return, they return
None.

.. function:: current()

   Return the log record to which the log currently refers.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcget.html#get_DB_CURRENT>`__

.. function:: first()

   The first record from any of the log files found in the log
   directory is returned.

   This method will return None if the log is empty. 

   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcget.html#get_DB_FIRST>`__

.. function:: last()

   The last record in the log is returned.

   This method will return None if the log is empty. 

   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcget.html#get_DB_LAST>`__

.. function:: next()

   The current log position is advanced to the next record in the log,
   and that record is returned. If the cursor position was not set
   previously, it will return the first record in the log.

   This method will return None if the log is empty. 

   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcget.html#get_DB_NEXT>`__

.. function:: prev()

   The current log position is advanced to the previous record in the
   log, and that record is returned. If the cursor position was not set
   previously, it will return the last record in the log.
   
   This method will return None if the log is empty. 

   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcget.html#get_DB_PREV>`__

.. function:: set(lsn)

   Retrieve the record specified by the lsn parameter.

   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/logcget.html#get_DB_SET>`__

