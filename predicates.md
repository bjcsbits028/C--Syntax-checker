#PREDICATES AND VARIABLES USED

###Top Level Predicates

1.	is_correct([[],[]...],['','','',''....],ANS)
	
	Details refer to [Basic Information][111].

2.	look(X, Z ,A) 			
	
	X is the first list of the input as given in is_correct() functor, 
	Z is the variable name to be searched in the list, 
	A is an auxilliary variable

3.	pop(List1, X, List2) 	
	
	It is used to implement the standard pop operation as in a stack with an element being removed from List1 to form List2

4.	push(X, List1, List2) 	

	It is used to implement the standard push operation as in a stack with an element X being appended to List1 to form List2

5.	checker(X, W, Ans, []) 	
	
	X is the first list of input, 
	W is the second list, 
	Ans is an auxilliary variable,[] is an empty list
	
	This is the main functor doing the type checking. It is based on the similar concept of evaluating an expression given in reverse polish notation. The type of each variable and constant is pushed into the stack continuously and when an operator is encountered, type checking is done while popping the members from the stack till the expression is found to be type correct. The intermediate result of the expression evaluated is again pushed to the stack. Once the stack is empty, we get the final result of the expression.

6.	head(X,[X|_]

	It is used to extract the head element of a list into X.

7.	second(X,[_X|_] 

	It is used to extract the second element of a list into X.

8.	operator(X) 

	It is used to check whether X is a valid operator or not.

9.	binop(X) 

	It is used to check whether X is a binary operator or not.

10.	unop(X) 

	It is used to check whether X is an unary operator or not.


###Some Built-in Predicates in Prolog

1. 	last(List, X)

2. 	member(X,List)

3. 	integer(X)

4. 	float(X)

5. 	number(X)

###Categories of Operators used

1.	arop

2.	tercop

3.	terqop

4.	varop

5.	varbop

6.	varintbop

7.	relop

8.	bitop

9.	bitintop

10.	addop

11.	boolop

12.	bituop

13.	booluop



[111]: 