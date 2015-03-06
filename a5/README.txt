Name 1:		Minwoo Kim
Student#:	66294083

Name 2:		Geon Young Park
Student#:	22835136

Question 2

Function | N = 64 | N = 60 |
sumA	 |  0.25  |  0.25  |
sumB     |  1.00  |  0.25  |
sumC     |  0.50  |  0.25  |

N = 64 & sumA
The rate of cache miss is 25%. The first access will always be a cold miss and after the first miss, 
the cache block will have the 4 ints in the array in row-major order due to the 16-byte block size. 
Hence, there will be only one miss out of 4 accesses.


N = 64 & sumB
Assume [row][column]
Using Excel we calculated index #'s of the first, second and fifth columns. Then, we observed that
the index numbers loop after reading 16 elements of the first column. For example, the 1st element to read ([0][0]) would
have index number 0, the second element to read ([1][0]) would have index number 16 while the 17th element to read ([16][0])
would have index number 0 which would overwrite the cache set that contained 1st element. This pattern continues on,
therefore, there are always cache misses despite 4 integers being stored in the cache. None of the other 3 integers
stored in the caches would be read before being overwritten.

The rate of cache miss is 100%. Since every read attempt will replace a cache line, each of the accesses
will result in a cold miss. This is because sumB is accessing in column-major order while the array is 
stored in row-major order.  


N = 64 & sumC (Assuming column number starts from 1)
The rate of cache miss is 50%. sumC reads the array in a 2x2 square. Hence, once blocks are fetched, 
half of the accesses (odd-numbered column) will be a miss and the other half (even-numbered column) of the 
accesses will be a hit giving the miss rate of 50%.


N = 60 & sumA
The rate of cache miss is 25%. Since both cache and array are stored and accessed in row-major order, 
the first access will always be a cold miss and the next 3 accesses will be hits. Hence, there will be 
one miss out of 4 accesses.


N = 60 & sumB
Using Excel we calculated index #'s of the first few columns. Then, we observed that
the index numbers are very unique for the first four columns at least. Hence, the cache 
miss rate is 25%. When the elements of the first column is accessed, it will all be a cold miss. 
However, when the elements of the second, third, and forth columns are accessed, since the cache sets are 
not replaced yet, they will all be a cache hit giving one miss out of 4 accesses, which is 25% miss rate.


N = 60 & sumC  
The cache miss rate is 25%. When the elements of the first column are accessed, there will be a cold miss.
However, since sumC reads the array in a 2x2 sqaure, the elements of the second column will be hits. When
elements of the third and forth columns are accessed, there will be cache hits since cache sets are not replaced yet. 
Since this goes in a pattern for following columns, there will always be one miss out of 4 accesses giving 25% 
cache miss rate.

Question 3

Assuming that one wants to know the associativity of n+1 level cache, given a memory access pattern with a stride, S 
and number of elements accessed, N, make a test setting S to be equal to the size of n+1 level cache, which can be 
determined by looking at a cache mountain graph. Then by varying N and measuring access time for each N, one can know
the associativity of n-th level cache as n+1th level cache has a bigger size than nth cache and as the associativity of
n+1th level cache is bigger than nth cache. n+2th and n+3th cache can be determined the same way as well. 

26 hours
