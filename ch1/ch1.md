# Introduction

> Master software engineers have the ability to organize programs so that they can be reasonably sure that the resulting processes will perform the tasks intended (predictability is a must). They can visualize the behavior of their systems in advance. They know how to structure programs so that unanticipated problems do not lead to catastrophic consequences, and when problems do arise, they can debug their programs. Well-designed computational systems, like well-designed automobiles or nuclear reactors, are designed in a modular manner, so that the parts can be constructed, replaced, and debugged separately.


## Elements of Programming

> The language also serves as a framework within which we organize our ideas about processes. We need to pay particular attention to the means that the language provides for combining simple ideas to form more complex ones, which can be achieved with three mechanisms:

- primitive expressions
- means of combination
- means of abstraction

The interpreter operates in the same basic cycle: it reads an expression from the terminal, evaluates the expression and then prints the result. This is the called REPL (read-eval-print-loop).

In scheme, `define` is the language's simplest mean of abstraction.

Complex programs are constructed by building, step by step, computational objects of increasing complexity. The possibility of associating values with symbols and later retrieving them means that the interpreter must maintain some sort of memory that keeps tracking of the name-object pairs. This is called `environment`.

### Evaluating Combinations

Evaluating combinations is itself a procedure as, to evaluate:

1. Evaluate the subexpressions of the combination
2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

This definition is, by itself, a recursive one as, to accomplish the evaluatin process for a combination we must first perform the evaluation process on each element of the combination.

In general, we shall see that recursion is a very powerful technique for dealing with hierarchical, treelike objects. In fact, the ``percolate values upward'' form of the evaluation rule is an example of a general kind of process known as tree accumulation.

It must be noticed that this evaluation rule will not apply to all expresions. With `define`, for example, the rule above mentioned is not the true evaluation that will happen. These special forms  - the various kind of expressions - is what constitutes the syntax of the programming language.

### Compound procedures

We can also give a name to compound operations so that we are able to refer to them as unit.

```scheme
(define (<name> <formal parameters>) <body>)
```

As we are then able to create compound operations with procedures, there are more than only one way to evaluate these.

#### Applicative-order evaluation


#### Normal-order evaluation

### Conditional Expressions and Predicates

```scheme
(cond (<p1> <e1>)
					....
			(<pn> <en>))

```

### Procedures as Black-Box Abstractions

It is crucial that each procedure accomplishes an identifiable task that can be used as a module in defining other procedures.

A formal parameter of a procedure has a very special role in the procedure definition, in that it doesn't matter what name the formal parameter has. Such a name is called a bound variable, and we say that the procedure definition binds its formal parameters. If a variable is not bound, we say that it is free. The set of expressions for which a binding defines a name is called the scope of that name. In a procedure definition, the bound variables declared as the formal parameters of the procedure have the body of the procedure as their scope.

By using what we know, we are able to take advantage of lexical scoping.


## Procedures and the Processes they Generate

A procedure is a pattern for the local evolution of a computational process.


## Linear Recursion and Iteration

In recursion, the process builds up a chain of deferred operations (in this case, a chain of multiplications). The contraction occurs as the operations are actually performed. This type of process, characterized by a chain of deferred operations, is called a recursive process. Carrying out this process requires that the interpreter keep track of the operations to be performed later on.

In general, an iterative process is one whose state can be summarized by a fixed number of state variables, together with a fixed rule that describes how the state variables should be updated as the process moves from state to state and an (optional) end test that specifies conditions under which the process should terminate.

In the iterative case, the program variables provide a complete description of the state of the process at any point. If we stopped the computation between steps, all we would need to do to resume the computation is to supply the interpreter with the values of the three program variables. Not so with the recursive process. In this case there is some additional `hidden` information, maintained by the interpreter and not contained in the program variables, which indicates `where the process is` in negotiating the chain of deferred operations. The longer the chain, the more information must be maintained.

*ps:  The implementation of Scheme we shall consider in chapter 5 does not share this defect. It will execute an iterative process in constant space, even if the iterative process is described by a recursive procedure. An implementation with this property is called tail-recursive. With a tail-recursive implementation, iteration can be expressed using the ordinary procedure call mechanism, so that special iteration constructs are useful only as syntactic sugar. The interpretation of these recursive procedures, in this case, won't consume an amount of memory that grows with the number of procedure calls.*

### Tree Recursion

For tree recursion, the process uses a number of steps that grows exponentially with the input. On the other hand, the space required grows only linearly with the input, because we need keep track only of which nodes are above us in the tree at any point in the computation. In general, the number of steps required by a tree-recursive process will be proportional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree.


# Formulating Abstractions with Higher-Order Procedures

Procedures that manipulate procedures are called higher-order procedures.

