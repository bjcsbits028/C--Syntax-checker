#INPUT FORMAT

	is_correct([[],[]...],['','','',''....],ANS)

1)	The first list in input of "is_correct" functor is a list of lists. The list consists of variables (no constants) with their data types types in the format ['type_of_variable', 'variable_name']. 

 In case the variable is of data type of address of any other data type, (such as address to int, address to bitset etc.) the format should be of the format ['address', 'type_of_variable', 'variable_name'].

 In case you wish to enter no variables in expression, the first list should of the type [[]], because the input is always list of lists.
			
 Example of a sample list is as below:  

	[['int', 'x'], ['float', 'y'], ['boolean', 'z'], ['address', 'int', 'w']]
		
2)	The second list contains the expression containing variables/constants/	operators in Reverse polish notation. (For details refer to [Appendix][111]).

 Constants of type int and float(eg 2, 4.05) should be entered without ''.

 Constants of type boolean (i.e. true and false) should be entered in quotes 

 All other variables and operators should be entered inside ' '. 

3)	The third member is simply the variable ANS.



[111]: https://github.com/likecs/C--Syntax-checker/blob/master/appendix.md