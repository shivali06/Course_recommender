% Computer science Course Recommender
% Shivali Choudhary

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Welcome instruction
 start :- 	write("Welcome to the CSUEB Computer science Course Recommender."),nl,
            sleep(0.2),
            write("Below are the few commands that will help you get course recommendation"),nl,
    		write("'?-getsem' would give recommendation for the semester"),nl,
    		write("?-getgrad' would give you recommendation according to your grade"),nl,
    		write("'?-getlike' would give you courses according to your interest"),nl,
    		write("'?-getpre' would give courses according to your eligible completed pre requisite"),nl,
    		write("'?-rcmndtn' would give you recommendation which is perfect for you"),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% To collect recommendation according to semsester
getsem :-
    			write('Which is your current semester?'),nl,
				read(Sem),nl,
				check_sem(Sem, Crs),
				write(Crs),nl.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% courses of the current semester
check_sem(A,C) :-
				info(C,_,_,A,_,_,_,_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% To collect the course recommendation from merit courses

getgrad	:-
    		write('List the subjects in which you scored grad A? ex.[cs601]'),nl,
			read(L),nl,
    		check_qlt(L,C),
			write(C),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* I implemented this to get courses according to some qualities of  subject for example analysis
%  This is used to find all qualities attached to a subject
find_tag(C,T):- info(C,_,_,_,_,_,_,T). 
% This is used to get course name by passing the quality name for example analysis	
find_crs(T,C):-  info(C,_,_,_,_,_,_,L),contains(T,L). */

% contains(A,B) would tell if list B contains the element A

contains(V,[V|T]).
contains(V,[H|T]) :-	contains(V,T),
    					dif(V,H).
% This would provide list of all courses in scored A grade
check_qlt(L,C) :-	info(C,_,_,_,_,_,_,T),
					qlt_atleast(L,T).
    				
	
% qlt_atleast(L,T) would tell us that T list may contain atleast one element 
% of qualities courses in L
qlt_atleast([C|R],T) :- qlt_atleast(R,T).
qlt_atleast([C|R],T) :- info(C,_,_,_,_,_,_,Q),
    					list_overlap(Q,T).

% list_overlap(L,Q) is check for at least one element is same
list_overlap(L,[H|R]) :- contains(H,L).
list_overlap(L,[H|R]) :- list_overlap(L,R).


	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% It would collect the info from user and suggest the subject
getlike :-

    			write('   What do you like most '),nl,
				write('1. theory'),nl,
				write('2. programming'),nl,
				read(Cat),nl,
				write('   which you enjoy most? '),nl,
				write('1. logic'),nl,
				write('2. security'),nl,
				write('3. data'),nl,
    			write('4. probability'),nl,
				read(Type),nl,

				write('Thanks to your answers we recommend following course:'),nl,
				recommendation(Cat, Type, Genre),
				write(Genre),nl.
				
				
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

recommendation(X, Y, C) 		:- info(C,_,_,_,_,X,Y,_) . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getpre :-
    	write('Please write completed pre req subjects ex. [cs401,cs421]'),nl,
    	read(Pre),nl,
    	write('Here are the eligible subjects according to your completed pre req'),nl,
    	pr(Pre, C),
    	write(C),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% It would give data of the pre req subjects
pr(L, C) :- info(C,_,_,_,P,_,_,_),
						comparelst(L,P).

% comparelst(A,B) would tell all the element of the list
comparelst(_,[]).
comparelst(L,[H|T]) :- contains(H,L),
						comparelst(L,T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this would give according to scoreing grade A and pre requisite of completed courses
rcmndtn :-
    		write('Please write completed pre req subjects ex. [cs401,cs421]'),nl,
    		read(P),nl,
    		write('please write subject you got A ex. [cs601]'),nl,
    		read(T), nl,
    		%write('Write the semester you are in'),nl,
    		%read(Y),nl,
    		gather(P,T,C),
    		write(C),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gather(P,T,C) :-
	pr(P,C),
	check_qlt(T,C),
    %check_sem(Y,C),
    not_in(T,C),
    not_in(P,C).

not_in([],C).
not_in([H|T],C) :-	dif(H,C),
					not_in(T,C).
	




% Computer science courses
info(cs601, 'advance algorithms', 601, 1, [cs401],'programming', 'logic',[ 'logic', 'problems']).
info(cs603, 'advanced software engineering', 603, 1, [cs401],'theory','data' ,['analysis','testing']).
info(cs605, 'information coding and cryptography', 605, 1, [],'theory', 'security',['cryptography', 'data','security']).
info(cs607, 'parallel programming', 607, 1, [cs421],'programming','logic', ['development', 'logic']).
info(cs611, 'theory of computation', 611, 1, [cs411],'theory', 'logic',['problems', 'logic','proofs']).
info(cs615, 'compiler design', 615, 2, [cs411], 'theory','logic', ['problems', 'logic','proofs']).
info(cs621, 'operating systems design', 621, 2, [cs421], 'programming','data', ['development', 'data','hardware']).
info(cs623, 'cloud computing', 623, 2, [cs421], 'programming','data', ['analysis', 'development', 'data']).
info(cs625, 'advanced computer architecture', 625, 2, [cs421],'theory', 'data',['analysis', 'problems']).
info(cs631, 'database systems', 631, 2, [cs431], 'programming','data', ['data', 'development', 'analysis']).
info(cs641, 'advanced computer networks', 641, 3,[cs441], 'programming','security',  ['hardware', 'networks']).
info(cs643, 'distributed systems', 643, 3, [cs441],'theory', 'logic',[ 'problems', 'logic']).
info(cs645, 'network analysis and design', 645, 3, [cs441],'programming', 'security', [ 'networks', 'hardware']).
info(cs651, 'webSystems', 651, 3, [cs401],'programming', 'logic', ['development', 'logic']).
info(cs661, 'advanced artificial intelligence', 661, 3, [cs411], 'programming','probability', ['development', 'logic', 'probability']).
info(cs663, 'computer vision', 663, 4, [cs401], 'programming','probability',  ['design', 'probability','development']).
info(cs665, 'Human-Computer Interaction', 665, 4, [cs401], 'programming', 'probability', ['design', 'interaction', 'analysis']).
info(cs667, 'machine learning', 667, 4, [], 'programming', 'probability',  [ 'development', 'stats', 'probability']).
info(cs671, 'cybersecurity', 671, 4, [cs471], 'theory', 'security', ['cryptography', 'security', 'hardware']).
info(cs681, 'digital signal processing', 681, 4, [cs401], 'theory', 'data', [ 'network', 'hardware', 'optimization']).
info(cs683, 'computer simulation', 683, 4, [cs401], 'theory', 'probability', ['analysis', 'design']).
