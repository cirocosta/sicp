# Modularity, Objects and State

In this CHp we are going to take the following strategy: for each object in the system, construct a corresponding computational object. For each system action, a symbolic operation in our computational model. Extending the model to accomodate new objects or new actions will require no strategic changes to the program. Two are going to be the 'world views' of structuring the system: objects and streams.

## Assignment and Local State

An object is said to have state if its behavior is influenced by its history. If we believe that we can model a system as a composition of many objects, we should then be able to decompose it into computational objects that model the actual objects in the system. Each object must have its own local state variables describing the actual object's state, also letting the system change these variables. We must, then, have an assignment operator in our language.

Although `set!` operations might be cool for letting us model the world in a 'more simple' way, this comes with a cost: our programming language can no longer be interpreted in terms of the substitution model of procedure application. We are getting far from the view of a functional programming language, where there is no use of assignments. With `set!` we mess up with the notion that substitution has regarding symbols: they are no longer just names for values, but a refereer to a place where a value can be stored.

Another problem is regarding sameness. Referential Transparency (an expression is said to be referentially transparent if it can be replaced with its value without changing the behavior of a program) is violated when we include `set!` in our computer language. This makes it tricky to determine when we can simplify expressions by substituting equivalent expressions. In general now we can only determine that two apparently objects identical objects are indeed *the same one* only by modifying one object and then observing wheter the other object has changed in the same way.

Another situation that might happen is the following:

```scheme
(define peter-acc (make-account 100))
(define paul-acc peter-acc)
```

Peter and Paul have, then, a join-account. If we are searching for all the places in our program where `paul-acc` can be changed we must remeber to look also at things that change `peter-acc`. The phenomenon of a single computational object being accessed by more than one name is known as aliasing.

In general, programming with assignment forces us to carefully consider the relative orders of the assignments to make sure that each statement is using the correct version of the variables that have been changed.

ps.: referential transparency is one of the principles of functional programming; only referentially transparent functions can be memoized. 
