.. $Id: dbsequence.rst,v 337846be2a21 2010/09/17 14:26:06 jcea $

==========
DBSequence
==========

Read `Oracle documentation
<http://download.oracle.com/docs/cd/E17076_02/html/programmer_reference/index.html>`__
for better understanding.

Sequences provide an arbitrary number of persistent objects that return
an increasing or decreasing sequence of integers. Opening a sequence
handle associates it with a record in a database. The handle can
maintain a cache of values from the database so that a database update
is not needed as the application allocates a value.

`More info...
<http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
C/seq.html>`__

DBSequence Methods
------------------

.. function:: DBSequence(db, flags=0)

   Constructor.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqcreate.html>`__

.. function:: open(key, txn=None, flags=0)

   Opens the sequence represented by the key.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqopen.html>`__

.. function:: close(flags=0)

   Close a DBSequence handle.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqclose.html>`__

.. function:: initial_value(value)

   Set the initial value for a sequence. This call is only effective
   when the sequence is being created.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqinitial_value.html>`__

.. function:: get(delta=1, txn=None, flags=0)

   Returns the next available element in the sequence and changes the
   sequence value by delta.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqget.html>`__

.. function:: get_dbp()

   Returns the DB object associated to the DBSequence.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqget_dbp.html>`__

.. function:: get_key()

   Returns the key for the sequence.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqget_key.html>`__

.. function:: remove(txn=None, flags=0)

   Removes the sequence from the database. This method should not be
   called if there are other open handles on this sequence.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqremove.html>`__

.. function:: get_cachesize()

   Returns the current cache size.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqget_cachesize.html>`__

.. function:: set_cachesize(size)

   Configure the number of elements cached by a sequence handle.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqset_cachesize.html>`__

.. function:: get_flags()

   Returns the current flags.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqget_flags.html>`__

.. function:: set_flags(flags)

   Configure a sequence.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqset_flags.html>`__

.. function:: stat(flags=0)

   Returns a dictionary of sequence statistics with the following keys:

     +------------+----------------------------------------------+
     | wait       | The number of times a thread of control was  |
     |            | forced to wait on the handle mutex.          |
     +------------+----------------------------------------------+         
     | nowait     | The number of times that a thread            |
     |            | of control was able to obtain handle mutex   |
     |            | without waiting.                             |
     +------------+----------------------------------------------+           
     | current    | The current value of the sequence            |
     |            | in the database.                             |
     +------------+----------------------------------------------+            
     | value      | The current cached value of the sequence.    |
     +------------+----------------------------------------------+
     | last_value | The last cached value of the sequence.       |
     +------------+----------------------------------------------+
     | min        | The minimum permitted value of the sequence. |
     +------------+----------------------------------------------+
     | max        | The maximum permitted value of the sequence. |
     +------------+----------------------------------------------+
     | cache_size | The number of values that will be cached in  |
     |            | this handle.                                 |
     +------------+----------------------------------------------+               
     | flags      | The flags value for the sequence.            |               
     +------------+----------------------------------------------+

   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqstat.html>`__

.. function:: stat_print(flags=0)

   Prints diagnostic information.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqstat_print.html>`__

.. function:: get_range()

   Returns a tuple representing the range of values in the sequence.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqget_range.html>`__

.. function:: set_range((min,max))

   Configure a sequence range.
   `More info...
   <http://download.oracle.com/docs/cd/E17076_02/html/api_reference/
   C/seqset_range.html>`__

