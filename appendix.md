*APPENDIX
									
This contains below steps to convert an expression into [Reverse Polish notation][111]. The below are some examples which also tell you the final input to be given in prolog for testing the code. 

***Example 1
Let the expression to be converted is '(x+y)*z', where 'x', 'y', 'z' are variables and '+' and '*' are opertaors.
	
Start with the first parenthesis, and write the variables in order before the operator, thus obtaining ['x','y','+']. Let us denote this intermediate expression by "ex"

So the expression becomes - "ex*z" which can again written as - ['ex','z','*'].

Now replace it with the list evaluated earlier.
		
['x','y','+','z','*'] is the final form required as input in Prolog.
	
***Example 2
Let the expression to be converted is '(x>y)?(a+b):(p/q)', where 'x', 'y', 'a', 'b', 'p', 'q' are variables and '>', '?', '+', ':' and '/' are opertaors.

The three expressions in parenthesis can be converted to reverse polish notation as ['x','y','>'],['a','b','+'],['p','q','/']. Let us denote these intermediate expressions by "ex1", "ex2" and "ex3".

So our input becomes of the form [ex1,'?',ex2,ex3,':'].
		
['x','y','>','?','a','b','+','p','q','/',':'] is the final form required as input in Prolog.

	
***Example 3
Let the expression to be converted is '(b=((true)?(a/(b-2)):(3*(4+5))))', where 'b', 'a' are variables, 'true', '3', '4', '5' are constants and '=', '?', '/', '-', ':' '*' and '+' are operators.
	
The expressions in brackets are be converted to reverse polish notation as ['a','b',2,'-','/'], [3,4,5,'+','*']. Let these expressions be "ex1" and "ex2".

Now we get the modified expression as "b=((true)?ex1:ex2)". 

Using the above method for conditional expression, we get ['true','?','ex1','ex2',':']. Let us call this "ex3".

So the expression becomes "b=ex3", which in reverse polish notation can be written as ['b','ex3','='].

['b', 'true', '?', 'a', 'b', 2, '-', '/', 3, 4, 5, '+', '*',':', '='] is the final form required as input in prolog.

Please apply the above definition recusively to generate all the expressions.

Note that we have assumed our own reverse polish notation regarding conditional("?" and ":") and equal-to("=") operations in C.

[111]: https://en.wikipedia.org/wiki/Reverse_Polish_notation