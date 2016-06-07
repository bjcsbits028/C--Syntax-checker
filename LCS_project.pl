%		***************LOGIC IN COMPUTER SCIENCE PROJECT- C PROGRAM TYPE CHECKER***************

%FACTS - OPERATOR LIST
%arithmetic operators
arop('+').              
arop('-').
arop('*').
arop('/').
arop('%').

%ternary opeartor
tercop(':').
terqop('?').

%arithemetic opertors with equal to
varop('=').
varop('+=').
varop('-=').             
varop('*=').                 
varop('/=').
varop('%=').

%bitwise operators with equal to
varbop('&=').
varbop('|=').
varbop('~=').
varintbop('>>=').
varintbop('<<=').

%relational operators
relop('==').
relop('>').
relop('<').              
relop('>=').                 
relop('<=').
relop('!=').

%bitwise operators
bitop('&').
bitop('|').          
bitintop('>>').          
bitintop('<<').     

%operators related to pointers in C
addop('&').           
addop('*').

%boolean operators
boollop('==').
boolop('&&').        
boolop('||').
boolop('!=').

%biwise unary operators
bituop('~').                   
booluop('!').          

%FUNCTOR- OPERATOR CHECKING
operator(Z):- arop(Z);varop(Z);varbop(Z);varintbop(Z);relop(Z);bitop(Z);bitintop(Z);bituop(Z);booluop(Z);boolop(Z);addop(Z);tercop(Z);terqop(Z).
binop(Z):- arop(Z);varop(X);varbop(Z);varintbop(Z);relop(X);bitop(X);bitintop(X);bituop(Z);booluop(Z);boolop(Z);tercop(Z).	
unop(Z):- addop(Z);bituop(Z);booluop(Z);terqop(Z).

%FUNCTOR- STACK OPERATIONS
empty([]).
pop([X|List],X,List).
push(X,List,[X|List]).

%FUNCTOR - ELEMENT SEARCHER IN LIST
head(W, [W|_]).
second(W, [_,W|_]).

%FUNCTOR - FINDING VARIABLE TYPE
%base case
look(Z, [], A).	

%recursive step
look(Z, [H|T], A) :- (
					last(H, Z) -> head(W, H), (
							W = 'address' -> (
								second('int', H) -> A = 'address_to_int';
								second('float', H) -> A = 'address_to_float';
								second('boolean', H) -> A = 'address_to_boolean';
								second('bitset', H) -> A = 'address_to_bitset';
								writeln('Input Error'), abort	
							);
							member(W, ['int']) -> A = 'var_int';
							member(W, ['float']) -> A = 'var_float';
							member(W, ['boolean']) -> A = 'var_boolean';
							member(W, ['bitset']) -> A = 'var_bitset';
							writeln('Datatype is incorrect'), abort
						); 
						look(Z, T, A)
					).

%FUNCTOR- TYPE CHECKER (MAIN PROGRAM CALL LINE)
is_correct(X, W, ANS):-	checker(X, W, ANS, []).

%FUNCTOR - REVERSE POLISH STRING TYPE CHECKER
%base case
checker(X, [], ANS, []) :- writeln('Empty expression.').

%print final ans
checker(X, [], ANS, [H|StackQ]) :- write('ANS='), writeln(H), abort.

%recursive step
%used if-elseif-else opeartions
checker(X, [Q|Z], ANS, Stack1):- writeln(Stack1), (
		%built-in function to check whether input is number or not
		number(Q) -> (
			integer(Q) -> 
				ANS = 'int', push(ANS, Stack1, Stack), checker(X, Z, J, Stack);
			float(Q) -> 
				ANS = 'float', push(ANS, Stack1, Stack), checker(X, Z, J, Stack);
			writeln('Input Error'), abort
		);
		
		member(Q,[true,false]) -> 
			ANS = 'boolean', push(ANS, Stack1, Stack), checker(X, Z, J, Stack);
		
		operator(Q) -> (
			pop(Stack1, Second, Stack), (
				unop(Q) -> (
					member(Q, ['!']) -> (
						member(Second, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset', 'boolean', 'var_boolean']) ->
							ANS = 'boolean', writeln(Stack), push(ANS, Stack, StackF);
						writeln('false'), abort
					);
					member(Q, ['~']) -> (
						member(Second, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset']) ->
							ANS = 'bitset', push(ANS, Stack, StackF);
						writeln('false'), abort
					);
					terqop(Q) -> (
						member(Second, ['boolean', 'var_boolean']) -> StackF = Stack;
						writeln('The test expression should have evaluated to boolean'), abort
					);
					member(Q, ['*']) -> (
						member(Second, ['address_to_int']) ->
							ANS = 'var_int', push(ANS, Stack, StackF);
						member(Second, ['address_to_float']) ->
							ANS = 'var_float', push(ANS, Stack, StackF);
						member(Second, ['address_to_bitset']) ->
							ANS = 'var_bitset', push(ANS, Stack, StackF);
						member(Second, ['address_to_boolean']) ->
							ANS = 'var_boolean', push(ANS, Stack, StackF);
						
						pop(Stack, First, StackT), (
							member(First, ['int', 'var_int']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['float', 'var_float']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								member(Second, ['float', 'var_float']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								member(Second, ['bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort	
							);
							writeln('false'), abort
						);
						writeln('false'), abort
					);
					member(Q, ['&']) -> (
						member(Second, ['var_int']) ->
							ANS = 'address_to_int', push(ANS, Stack, StackF);
						member(Second, ['var_float']) ->
							ANS = 'address_to_float', push(ANS, Stack, StackF);
						member(Second, ['var_bitset']) ->
							ANS = 'address_to_bitset', push(ANS, Stack, StackF);
						member(Second, ['var_boolean']) ->
							ANS = 'address_to_boolean', push(ANS, Stack, StackF);
						pop(Stack, First, StackT), (
							member(First, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset'])->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							writeln('false'), abort
						);
						writeln('false'), abort
					);
					writeln('Sorry, We are Wrong'), abort
				);

				pop(Stack, First, StackT), (
					binop(Q) -> (
						varop(Q) -> (
							member(First, ['var_int', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['var_float', 'var_bitset']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['var_boolean']) -> (
								member(Second, ['boolean', 'var_boolean']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);	 									
							writeln('Only variables are permitted on the LHS of an assignment'), abort
						);
						member(Q, ['+', '-']) -> (
							member(First, ['int', 'var_int']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['float', 'var_float']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								member(Second, ['float', 'var_float']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								member(Second, ['bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort	
							);
							member(Q, ['+']) -> (
								member(First, ['address_to_int']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_int', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										writeln('two addresses cannot be added'), abort;
									writeln('type incompatibilty'), abort
								);
								member(First, ['address_to_float']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_float', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										writeln('two addresses cannot be added'), abort;
									writeln('type incompatibilty'), abort
								);
								member(First, ['address_to_boolean']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_boolean', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										writeln('two addresses cannot be added'), abort;
									writeln('type incompatibilty'), abort
								);
								member(First, ['address_to_bitset']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_bitset', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										writeln('two addresses cannot be added'), abort;
									writeln('type incompatibilty'), abort
								);
								writeln('false'), abort
							);
							member(Q, ['-']) -> (
								member(First, ['address_to_int']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_int', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										ANS = 'int', push(ANS, StackT, StackF);
									writeln('type incompatibilty'), abort
								);
								member(First, ['address_to_float']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_float', push(ANS, StackT, StackF);
									member(Second, ['address_to_float', 'address_to_int', 'address_to_boolean', 'address_to_bitset']) ->
										ANS = 'int', push(ANS, StackT, StackF);
									writeln('type incompatibilty'), abort
								);
								member(First, ['address_to_boolean']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_boolean', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										ANS = 'int', push(ANS, StackT, StackF);
									writeln('type incompatibilty'), abort
								);
								member(First, ['address_to_bitset']) -> (
									member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
										ANS = 'address_to_bitset', push(ANS, StackT, StackF);
									member(Second, ['address_to_int', 'address_to_float', 'address_to_boolean', 'address_to_bitset']) ->
										ANS = 'int', push(ANS, StackT, StackF);
									writeln('type incompatibilty'), abort
								);
								writeln('false'), abort
							);
							writeln('false'), abort
						);
						member(Q, ['/']) -> (
							member(First, ['int', 'var_int']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['float', 'var_float']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								member(Second, ['float', 'var_float']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								member(Second, ['bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort	
							);
							writeln('false'), abort
						);
						member(Q, ['%']) -> (
							member(First, ['int', 'var_int', 'bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								writeln('Right hand side of modulus operator should only be int'), abort
							);
							writeln('Left hand side of modulus operator should only be int'), abort
						);
						relop(Q) -> (
							member(First, ['int', 'var_int']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['float', 'var_float']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['bitset', 'var_bitset']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							writeln('false'), abort
						);
						boolop(Q) -> (
							member(First, ['int', 'var_int']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['float', 'var_float']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['bitset', 'var_bitset']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							member(First, ['boolean', 'var_boolean']) -> (
								member(Second, ['boolean', 'var_boolean']) ->
									ANS = 'boolean', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							writeln('false'), abort
						);
						bitop(Q) -> (
							member(First, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							writeln('false'), abort
						);
						bitintop(Q) -> (
							member(First, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('Right hand side of bitwise shift operator should only be int'), abort
							);
							writeln('false'), abort
						);
						varbop(Q) -> (
							member(First, ['var_int', 'var_float', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort
							);
							writeln('Only variables are permitted on the LHS of an assignment'), abort
						);
						varintbop(Q) -> (
							member(First, ['var_int', 'var_float', 'var_bitset']) -> (
								member(Second, ['int', 'var_int', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('Right hand side of bitwise shift operator should only be int'), abort
							);
							writeln('Only variables are permitted on the LHS of an assignment'), abort
						);
						tercop(Q) -> (
							member(First, ['int', 'var_int']) -> (
								member(Second, ['int', 'var_int', 'bitset', 'var_bitset']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								writeln('false'), abort
							);
							member(First, ['float', 'var_float']) -> (
								member(Second, ['float', 'var_float', 'bitset', 'var_bitset']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								writeln('false'), abort
							);
							member(First, ['bitset', 'var_bitset']) -> (
								member(Second, ['int', 'var_int']) ->
									ANS = 'int', push(ANS, StackT, StackF);
								member(Second, ['float', 'var_float']) ->
									ANS = 'float', push(ANS, StackT, StackF);
								member(Second, ['bitset', 'var_bitset']) ->
									ANS = 'bitset', push(ANS, StackT, StackF);
								writeln('type incompatibilty'), abort	
							);
							member(First, ['boolean']) ->
								ANS = 'boolean', push(ANS, StackT, StackF);
							member(First, ['address_to_int']) ->
								ANS = 'address_to_int', push(ANS, StackT, StackF);
							member(First, ['address_to_float']) ->
								ANS = 'address_to_float', push(ANS, StackT, StackF);
							member(First, ['address_to_bitset']) ->
								ANS = 'address_to_bitset', push(ANS, StackT, StackF);
							member(First, ['address_to_boolean']) ->
								ANS = 'address_to_boolean', push(ANS, StackT, StackF);
							writeln('Both Sides of conditional operator should evaluate to same type'), abort
						);
						writeln('false'), abort
					);
					writeln('false'), abort
				);
				writeln('less number of operands to operate on'), abort
			);
			writeln('less number of operands to operate on'), abort
		);
		look(Q, X, ANS), push(ANS, Stack1, Stack), checker(X, Z, J, Stack)	
	),
	checker(X, Z, J, StackF).

%			******************************END OF PROJECT******************************