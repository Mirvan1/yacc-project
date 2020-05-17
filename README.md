          PROGRAMMING LANGUAGE NL

Member: Mirvan SADIGLI
Syntax
<prog>::= <stmts>
<stmts>::=<package_stmt> <import_stmt> <block_stmt>
<block_stmt>::= <class_name><main_method><exception_handling><body|<method>
<class_name>::=identifier
<method>::=<method_name><body>
<method_name>::=identifier
<exception_handling>::=throw exception
<body>::= { <statement>}
<statement>::=<nonblock_stmt>|<block_stmt2>|;|<method_name>()
<nonblock_stmt>::=<var_dec>;|<expr>;| <single_stmt>
<single_stmt>:= <printer_stmt> | <scanner_stmt> | <comment>|  <end_program>
<printer_stmt>::= print();
<scanner_stmt>::= scanner();
 <end_program>::=end
<expr>::=<arithm_equal><|relational_exp
<block_stmt2>::=<conditional_stmt> | <loop_stmt> |<try_stmt>
<var_dec>::=  <datatypes>|<text_type>
<datatype>::= <int>< id1>|<float><id2>| <boolean><id3>
<text_type>:: = <String><id4>|<char><id5>
<id1>::=identifier= <arithm_equal>|identifier=<relational_exp>
<id2>::=identifier= <arithm_equal>|identifier,identifier|identifier
<id3>::=identifier|identifier=<relational_exp>
<id4>::=identifier=string
<id4>::=identifier=char
<conditional_stmt>::=<if_cond_exp> |<elif_cond_exp> |<else_cond_exp>
 <if_cond_exp>::= if (<cond_op>) <body>
<else_cond_exp>::= else <body>
<for_stmt>::= for( <arg1> ; <arg2> ; <arg3>)  <body>
<arg1::=var_dec|expr
<arg2>::=relational_exp
<arg3>::=arithm_e
<try_stmt>::= try { <try_m>}
<try_m>:: catch{ catch_m }
<package_stmt>::=package identifier ;
<import_stmt>::=import identifier .*;|import <class_name>;|import *;
<comment>::= #|/*….*/
<int>::= <int> <op> <int> | <int> <relational_op> <int>? | <digit>
<float>::= <float> <op> <float> | <float> <relational_op> <floatt>? | <int>.<digit>
 <boolean>::= true | false 
<String>::=<letter> | <digit> | <symbol>
<char>::=<charachter>
 <charachter>::=<letter> | <digit> | <symbol>
 <cond_op>::=<expr> && <expr> | <expr> || <expr> 
 <relational_op> ::= ++ |-- |< | <= | > | >= | != | ==
 <symbol>::=  ' | " | , |; | = | ( | ) | { | } | [ | ]
 <op>::= + | - | * | / | =
 <digit> ::=0 | 1 |....| 9
<letter> ::= a | b ...| z | A | B ...| Z |




This interpreter is a new programming language which is a functional programming language. The programming language name is START.As seen in the name, it is suitable for those just starting the learning programming.It is useful for those who are interested in software and do not know where to start.These people should start with START to learning programming.It can be also used scientific calculator using a programming language. This language is easy to understand for beginners. It means that readability and writability is ease. It could be said that syntax is similar to Java and functionally similar to MATLAB. The programs are written here come with the .nl extension. There are 2 types of statements. The first one is non-block statements that do not need to body to execute (e.g integer). The second one is block statements that have a body to execute (e.g conditional statements).As shown above, there are two types in the NL. These are data type and text type. The datatype is an integer, floating numbers and boolean. Text type is String and char. As with most programming languages, curly braces should be used for the body. This software language can read via the input file. Print function is used to print statements.It print statement by statement and show in the terminal.Finally, the input file can be shown here. NL also provides you to print the text you want to the file. You can do this by using the "make scanner" command. By the way, you do not need to create the file before. To do this, you can write the "scanner" in the program and then write the word what you want in ONE line. Using the program I provided as an example, you can run with makefile.For this, you can run it by typing "make run"and "make nl" command in the terminal. You can use make clean command to delete the NL. You can do it with "end" to stop the program.Loop statement is a bit different than other programming languages.However, it has to be written loopEnd(); at the end of the loop STATEMENT.Start also has try-catch and throw exception handling. It is similar to java. The syntax is shown example file. I also add additional properties which looks like Java.These properties are import, package and main method. Also,you can invoke auxilary function in the main method as in java. You can run this language using terminal or text file(like gedit).In the terminal,  you can write codes STATEMENT-by-STATEMENT. If you make a mistake when you writing in terminal,the program is stopped and show error where it is. You can write comments to keep notes in the compiler.Comment has two types. These are #(only one line) and /*(multi line)*/.Compiler also have conditional and loop statements.You can see examples about conditional and loop statements in the example file.

