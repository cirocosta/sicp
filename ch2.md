# Building Abstractions with Data

In CH1 we focused on building abstractions by combining procedures to form compound procedures. In this we are going to examine means to provide compound data, i.e, building new abstractions by combining data objects.

We want compound data to elevate the conceptual level at which we can design our programs, increasing the modularity of our designs and enhancing the expressiveness power of our language.

The key to forming compound data is that a programming language should provide some kind of 'glue' so that data objects can be combined to form more complex data objects. It is interesting to notice that the 'glue' does not need to be anything special: just procedures.

## Data Abstraction

Data abstraction is a methodology that will enable us to isolate how a compound data object is used from the details of how it is constructed from more primitive data objects.

The idea that we'll carry from now on is that data abstraction will enable our programs to use compound data objects so that they will always be operating on 'abstract data', making no assumptions about the data that they are dealing with. At the same time a `concrete` data representation will be defined independent of the programs that use the data (making use through the abstraction).

We can think of data as defined by some collection of `selectors` and `constructors`, together with specified conditions that these procedures must fulfill in order to be a valid representation. These are going to be the interface between the two parts (abstract and cnocrete).

The ability to create pairs whose elements are pairs is the essence of list structure's importance as a representational tool. We refer to this ability as the closure property of cons (not related to the technique for representing procedures with free variables, but from the abstract algebra which states that a set of elements is said to be closed under an operation if applying the operation to elements in the set produces an element that is again an element of the set). The closure property is satisfied if the results of combining things with that operation can themselves be combined using the same operation..Closure is the key to power in any means of combination because it permits us to create hierarchical structures -- structures made up of parts, which themselves are made up of parts, and so on.

> "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures." 

100 functions on one data structure can be composed together in lots of unique ways, since they all operate on the same data structure. Mixing 10 functions on 10 data structures may not be possible since they are defined only to work on their particular data structure.

