#SAMPLE TEST CASES

Below is the list of some sample test cases with their respective output when the program was run in SWI_Prolog.

1. is_correct([['int', 'x'], ['int', 'y']], [2,3,'<','x' ,'y', '>','&&'], ANS).

	[]
	[int]
	[int,int]
	[boolean]
	[var_int,boolean]
	[var_int,var_int,boolean]
	[boolean,boolean]
	ANS=boolean

2. is_correct([['int', 'x'], ['int', 'y']], [2,'<','x' ,'y', '>','&&'], ANS).

	[]
	[int]
	less number of operands to operate on

3. is_correct([['bitset', 'x'], ['bitset', 'y']], ['x','y', 3 , '&', '~'], ANS).

	[]
	[var_bitset]
	[var_bitset,var_bitset]
	[int,var_bitset,var_bitset]
	[bitset,var_bitset]
	ANS=bitset

4. is_correct([['float', 'a'], ['address', 'int', 'b']], ['b', '*', '&', 'a', '+'], ANS).

	[]
	[address_to_int]
	[var_int]
	[address_to_int]
	[var_float,address_to_int]
	false

5. is_correct([['float', 'a'], ['address', 'int', 'b']], ['b', 'a', '+'], ANS).

	[]
	[address_to_int]
	[var_float,address_to_int]
	false

6. is_correct([['int', 'a'], ['address', 'int', 'b']], ['b', '*', '&', 'a', '+'], ANS).

	[]
	[address_to_int]
	[var_int]
	[address_to_int]
	[var_int,address_to_int]
	ANS=address_to_int

7. is_correct([['int', 'a'], ['int', 'b']], ['b', 3, '?', 'a', 'b', 2, '-', '/', 3, 4, 5, '+', '*',':', '='], ANS).

	[]
	[var_int]
	[int,var_int]
	The test expression should have evaluated to boolean

8. is_correct([['int', 'a'], ['int', 'b']], ['b', 'true', '?', 'a', 'b', 2, '-', '/', 3, 4, 5, '+', '*',':', '='], ANS).

	[]
	[var_int]
	[boolean,var_int]
	[var_int]
	[var_int,var_int]
	[var_int,var_int,var_int]
	[int,var_int,var_int,var_int]
	[int,var_int,var_int]
	[int,var_int]
	[int,int,var_int]
	[int,int,int,var_int]
	[int,int,int,int,var_int]
	[int,int,int,var_int]
	[int,int,var_int]
	[int,var_int]
	ANS=int

9. is_correct([['int', 'a'], ['int', 'b']], [4, 'true', '?', 'a', 'b', 2, '-', '/', 3, 4, 5, '+', '*',':', '='], ANS).

	[]
	[int]
	[boolean,int]
	[int]
	[var_int,int]
	[var_int,var_int,int]
	[int,var_int,var_int,int]
	[int,var_int,int]
	[int,int]
	[int,int,int]
	[int,int,int,int]
	[int,int,int,int,int]
	[int,int,int,int]
	[int,int,int]
	[int,int]
	Only variables are permitted on the LHS of an assignment

10. is_correct([['int', 'a'], ['int', 'b'], ['float', 'c'], ['float', 'd']], ['b', 'c', 'd', '>=','?', 'a', 'b', 2, '-', '/', 3, 4, 5, '+', '*',':', '='], ANS).

	[]
	[var_int]
	[var_float,var_int]
	[var_float,var_float,var_int]
	[boolean,var_int]
	[var_int]
	[var_int,var_int]
	[var_int,var_int,var_int]
	[int,var_int,var_int,var_int]
	[int,var_int,var_int]
	[int,var_int]
	[int,int,var_int]
	[int,int,int,var_int]
	[int,int,int,int,var_int]
	[int,int,int,var_int]
	[int,int,var_int]
	[int,var_int]
	ANS=int