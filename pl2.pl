:-dynamic(gamestate/1).
 gamestate([[],[],[],[],[],[],[]]).

%inclut les clauses des fichiers jouer.pl et aGagner.pl

:-use_module(library(random)).



%   ------------- jouer


jouer(x, Colonne) :-
	jouer(x, Colonne, _).

jouer(o, Colonne) :-
	jouer(o, Colonne, _).


jouer(Jeton,1,Newgamestate):-
	% on recupere toute les colonnes dans les variables
	gamestate(X), nth0(0, X, ColChoisi), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),                       %ici test si ColChoisi n'a pas deja 6 jetons
	append([Jeton],ColChoisi,NewCol),              %ajout du nouveau jeton

	retract(gamestate(_)),	                       %on retire la configuration du precedent gamestate en donnee
	assert(gamestate([NewCol,C2,C3,C4,C5,C6,C7])), %on insere la nouvelle configuration de gamestate en donnee
	gamestate(Newgamestate).                       %on affiche en resultat l'etat du gamestate apres le coup joue

jouer(Jeton,2,Newgamestate):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, ColChoisi), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	append([Jeton],ColChoisi,NewCol),

	retract(gamestate(_)),
	assert(gamestate([C1,NewCol,C3,C4,C5,C6,C7])),
	gamestate(Newgamestate).

jouer(Jeton,3,Newgamestate):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, ColChoisi), nth0(3, X, C4),nth0(4, X, C5),nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	append([Jeton],ColChoisi,NewCol),

	retract(gamestate(_)),
	assert(gamestate([C1,C2,NewCol,C4,C5,C6,C7])),
	gamestate(Newgamestate).

jouer(Jeton,4,Newgamestate):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, ColChoisi), nth0(4, X, C5),nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	append([Jeton],ColChoisi,NewCol),

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,NewCol,C5,C6,C7])),
	gamestate(Newgamestate).

jouer(Jeton,5,Newgamestate):-
	gamestate(X), nth0(0, X, C1),nth0(1, X, C2), nth0(2, X, C3),nth0(3, X, C4),nth0(4, X, ColChoisi), nth0(5, X, C6), nth0(6, X, C7),

	checkTaille(ColChoisi),

	append([Jeton],ColChoisi,NewCol),

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,C4,NewCol,C6,C7])),
	gamestate(Newgamestate).

jouer(Jeton,6,Newgamestate):-
	gamestate(X), nth0(0, X, C1),nth0(1, X, C2),nth0(2, X, C3),nth0(3, X, C4),nth0(4, X, C5),nth0(5, X, ColChoisi), nth0(6, X, C7),

	checkTaille(ColChoisi),

	append([Jeton],ColChoisi,NewCol),

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,C4,C5,NewCol,C7])),
	gamestate(Newgamestate).

jouer(Jeton,7,Newgamestate):-
	gamestate(X), nth0(0, X, C1), nth0(1, X, C2), nth0(2, X, C3), nth0(3, X, C4), nth0(4, X, C5), nth0(5, X, C6), nth0(6, X, ColChoisi),

	checkTaille(ColChoisi),

	append([Jeton],ColChoisi,NewCol),

	retract(gamestate(_)),
	assert(gamestate([C1,C2,C3,C4,C5,C6,NewCol])),
	gamestate(Newgamestate).

% regle verifiant si la liste passe en parametre est bien inferieure a 6
checkTaille(L):-
	length(L,Nb), Nb <6,!.

%regle envoyant un message d'erreur si la liste est deja égale ŕ 6
checkTaille(L):-
	length(L,Nb), not(Nb<6),
	gamestate(X),
	nth0(NumCol,X,L),
	NumCol1 is NumCol+1,
	write('La colonne ') , write(NumCol1) , write(' est deja rempli, veuillez sélectionner une autre'),false, !.



%------------------------ aGagner.pl

compareList([], []).
compareList(L1, L2) :-	
	L1 = [T1|Q1],
	L2 = [T2|Q2],
	T1 == T2,
	compareList(Q1, Q2).
	
compareList(L1, L2, Pion) :-	
	L1 = [T1|Q1],
	L2 = [T2|Q2],
	T1 == T2,
	T1 == Pion,
	compareList(Q1, Q2).
	

	
sv(x):-
	gamestate(Z),
	sv(x, Z).
	
sv(o):-
	gamestate(Z),
	sv(o, Z).

sv(Pion, Z):-
	length(Z,NbElements), NbElements > 3,
	nth0(0, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion);

	nth0(1, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion);
	 
	nth0(2, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion) ;
	
	nth0(3, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion) ;
	
	nth0(4, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion) ;
	
	nth0(5, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion) ;
	
	nth0(6, Z, Y), nth0(0, Y, C1), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), compareList([C1], [C2]), 
	compareList([C2], [C3]), compareList([C3], [C4], Pion).

sv(Pion, Z) :-

	length(Z,NbElements), NbElements > 3,

	nth0(0, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion) ;

	nth0(1, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion) ;

	nth0(2, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion) ;

	nth0(3, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion) ;

	nth0(4, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion) ;

	nth0(5, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion) ;

	nth0(6, Z, Y), nth0(1, Y, C2), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), 
	compareList([C2], [C3]), compareList([C3], [C4]), compareList([C4], [C5], Pion).
	
sv(Pion, Z) :-

	length(Z,NbElements), NbElements > 3,

	nth0(0, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion) ; 

	nth0(1, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion) ; 

	nth0(2, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion) ; 

	nth0(3, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion) ; 

	nth0(4, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion) ; 

	nth0(5, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion) ; 

	nth0(6, Z, Y), nth0(2, Y, C3), nth0(3, Y, C4), nth0(4, Y, C5), nth0(5, Y, C6), 
	compareList([C3], [C4]), compareList([C4], [C5]), compareList([C5], [C6], Pion). 
	
% on prend la premiere colone puis la deuxieme, puis ... Ensuite on prend le premier element de la colonne 1, puis le premier de la colonne 2, etc
% E5 est en trop : c'est bien puissance 4?
	
	% TODO : Regler le probleme d'ajout en debut de liste
	
sh(x):-
	gamestate(Z),
	sh(x, Z).
	
sh(o):-
	gamestate(Z),
	sh(o, Z).
	
sh(Pion, Z) :-
	nth0(0, Z, CI1), nth0(1, Z, CI2), nth0(2, Z, CI3), nth0(3, Z, CI4),
    reverse(CI1, C1), reverse(CI2, C2), reverse(CI3, C3), reverse(CI4, C4), 
	nth0(LineNumber, C1, E1),nth0(LineNumber, C2, E2),nth0(LineNumber, C3, E3),nth0(LineNumber, C4, E4),
	compareList([E1], [E2],Pion), compareList([E2], [E3]), compareList([E3], [E4],Pion),
	write("line number 1 "),
	write(E1),	write(E2),	write(E3),
	write(E4), writeln(""),
    write(Z).
	
sh(Pion, Z) :-
	nth0(1, Z, CI1), nth0(2, Z, CI2), nth0(3, Z, CI3), nth0(4, Z, CI4),
    reverse(CI1, C1), reverse(CI2, C2), reverse(CI3, C3), reverse(CI4, C4), 
	nth0(LineNumber, C1, E1),nth0(LineNumber, C2, E2),nth0(LineNumber, C3, E3),nth0(LineNumber, C4, E4),
	compareList([E1], [E2],Pion), compareList([E2], [E3]), compareList([E3], [E4],Pion),
	write("line number 2 "),
	write(E1),	write(E2),	write(E3),
	write(E4), writeln(""),
    write(Z).

sh(Pion, Z) :-
	nth0(2, Z, CI1), nth0(3, Z, CI2), nth0(4, Z, CI3), nth0(5, Z, CI4),
    reverse(CI1, C1), reverse(CI2, C2), reverse(CI3, C3), reverse(CI4, C4), 
	nth0(LineNumber, C1, E1),nth0(LineNumber, C2, E2),nth0(LineNumber, C3, E3),nth0(LineNumber, C4, E4),
	compareList([E1], [E2]), compareList([E2], [E3]), compareList([E3], [E4],Pion),
	write("line number 3 "),
	write(E1),	write(E2),	write(E3),
	write(E4), writeln(""),
    write(Z).

	
sh(Pion, Z) :-
	nth0(3, Z, CI1), nth0(4, Z, CI2), nth0(5, Z, CI3), nth0(6, Z, CI4),
    reverse(CI1, C1), reverse(CI2, C2), reverse(CI3, C3), reverse(CI4, C4), 
	nth0(LineNumber, C1, E1),nth0(LineNumber, C2, E2),nth0(LineNumber, C3, E3),nth0(LineNumber, C4, E4),
	compareList([E1], [E2],Pion), compareList([E2], [E3]), compareList([E3], [E4],Pion),
	write("line number 4 "),
	write(E1),	write(E2),	write(E3),
	write(E4), writeln(""),write(Z).


    	
sd(x):-
	gamestate(Z),
	sd(x, Z).
	
sd(o):-
	gamestate(Z),
	sd(o, Z).


sd(Pion, Z) :-

    % test des diagonales allant de gauche à droite, du haut vers le bas (   9 cas )
	length(Z,NbElements), NbElements > 3,
    
    % 1 diagonale
    nth0(0, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(1, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2),
    nth0(2, Z, Y2),  reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(3, Z, Y3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    % 2 diagonale
    nth0(0, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(1, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2),
    nth0(2, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(3, Z, YI3), reverse(YI3, Y3),nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(1, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(2, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2), 
    nth0(3, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(4, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    % 3 diagonale
    nth0(0, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(1, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(2, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(3, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(1, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(2, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(3, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(4, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    nth0(2, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(3, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2), 
    nth0(4, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(5, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    % 4 diagonale
    nth0(1, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(2, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(3, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(4, Z, YI3), reverse(YI3, Y0), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(2, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(3, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(4, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(5, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    nth0(3, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(4, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2), 
    nth0(5, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(6, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    % 5 diagonale
    nth0(2, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(3, Z, YI1), reverse(YI1, Y1), nth0(1, Y1, DG2), 
    nth0(4, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(5, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(3, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(4, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(5, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(6, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
     % 6 diagonale
    nth0(3, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(4, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(5, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(6, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
  
    % test des diagonales allant de droit à gauche, du haut vers le bas (   9 cas )

    % 1 diagonale
    nth0(6, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(5, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2), 
    nth0(4, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(3, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    % 2 diagonale
    nth0(6, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(5, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(4, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(3, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(5, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(4, Z, YI1), reverse(YI2, Y1), nth0(2, Y1, DG2), 
    nth0(3, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(2, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    % 3 diagonale
    nth0(6, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(5, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(4, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(3, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(5, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(4, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(3, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(2, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    nth0(4, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(3, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2), 
    nth0(2, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(1, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    % 4 diagonale
    nth0(5, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(4, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(3, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(2, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(4, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(3, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(2, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(1, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    nth0(3, Z, YI0), reverse(YI0, Y0), nth0(3, Y0, DG1),
    nth0(2, Z, YI1), reverse(YI1, Y1), nth0(2, Y1, DG2), 
    nth0(1, Z, YI2), reverse(YI2, Y2), nth0(1, Y2, DG3),
    nth0(0, Z, YI3), reverse(YI3, Y3), nth0(0, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
    % 5 diagonale
    nth0(4, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(3, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(2, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(1, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ; 
    
    nth0(3, Z, YI0), reverse(YI0, Y0), nth0(4, Y0, DG1),
    nth0(2, Z, YI1), reverse(YI1, Y1), nth0(3, Y1, DG2), 
    nth0(1, Z, YI2), reverse(YI2, Y2), nth0(2, Y2, DG3),
    nth0(0, Z, YI3), reverse(YI3, Y3), nth0(1, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) ;
    
     % 6 diagonale
    nth0(3, Z, YI0), reverse(YI0, Y0), nth0(5, Y0, DG1),
    nth0(2, Z, YI1), reverse(YI1, Y1), nth0(4, Y1, DG2), 
    nth0(1, Z, YI2), reverse(YI2, Y2), nth0(3, Y2, DG3),
    nth0(0, Z, YI3), reverse(YI3, Y3), nth0(2, Y3, DG4),
    compareList([DG1], [DG2]), compareList([DG2], [DG3]), compareList([DG3], [DG4], Pion) .




%------------------------ affichage
%principe : Affiche les elements du jeu en faisant un parcours d'une
% grille de gauche a droite en commencant par l'etage 6 (étage du haut)
% puis en descendant jusqu'a la fin du jeu etage 1

:-dynamic iteration/1.
iteration([6,5,4,3,2,1]).

%affiche toute la grille grace a un nombre d'iteration predefini
afficherGrille :-
	iteration(Y), Y = [Tete|_],
	writeln('\n   _\n'),
	gamestate(X), afficherGrille(X, Tete).


%regle d'arrivee a la fin du ligne
afficherGrille([], _) :-
	finLigne.

%affiche la ligne NumLigne du jeu Gamestate
afficherGrille(Gamestate, NumLigne) :-
	write('  |  '),
	%recupere la premiere liste ( la premiere colonne du jeu) dans Tete
	Gamestate = [Tete|Queue],
	length(Tete, Longueur),
	%calcul le NbElementsVides a partir de la ligne NumLigne de la grille
	NbElementsVides is NumLigne-Longueur,
	ecrireElement(Tete, Queue, NumLigne, NbElementsVides).

finAfficherGrille :-
	retract(iteration(_)) , assert(iteration([6,5,4,3,2,1])).

ecrireElement(Colonne, ColonnesSuivantes, NumLigne, NbElementsVides) :-
	NbElementsVides =< 0,
	%Colonne = [Tete|_],
	Index is NumLigne - 1 ,    %indice commence a partir de 0
	%on renverse l'orde des éléments de la colonne pour l'affichage!
	reverse(Colonne,ColonneReversed),
	nth0(Index,ColonneReversed,Elem),
	write(Elem),
	afficherGrille(ColonnesSuivantes, NumLigne).

ecrireElement( _ , ColonnesSuivantes, NumLigne, NbElementsVides) :-
	NbElementsVides > 0,
	!,
	write('_'),
	afficherGrille(ColonnesSuivantes, NumLigne).

finLigne :-
	write('  |\n'),
	writeln('\n'),
	iteration(X), pop(X, Y),
	retract(iteration(X)) , assert(iteration(Y)),
	testTableauIteration(Y).

testTableauIteration(Iteration) :-
	Iteration = [IterationCourante| _ ],% [IterationCourante|IterationRestantes],
	!,
	write('\n'),
	gamestate(X), afficherGrille(X, IterationCourante).

testTableauIteration([]) :-
	finAfficherGrille.

pop(Liste, Queue) :-
			Liste = [_|Queue].




%-------------------------- ia.pl

iaRandom(Pion) :-
		random(1, 7, Colonne),
		jouer(Pion, Colonne).
		
		
		
		

%condition d'arret de la recusion:
coupPossible([],[]).

% Principe: Au depart on passe en parametre l'etat du jeu ( la liste de
% liste )
% On recupere la premiere colonne (tete de la liste) puis on fait une
% recursion sur toute les colonnes suivante jusqu'a tomber sur une liste
% vide (marque de fin)
% Puis on dépile la recusion dans l'autre sens en ajoutant dans
% listResult l'index de la colonne ou on peut encore jouer
coupPossible(Gamestate,ListResult):-
	Gamestate = [Tete|Queue],

	%on test si la colonne n'est pas remplie
	length(Tete,Taille) , Taille <6,

	%si test reussi (true)
	%on cherche l'index de cette colonne dans Gamestate
	length(Queue,Taille2),
	Index is 7 - Taille2,
	%gamestate(Static),
	%nth0(Index,Static,Tete),

	%(recursion) on fait un parcours de chaque colonne ainsi
	coupPossible(Queue,L),
	%on ajoute cet index a la liste de coups possible
	append([Index],L,ListResult).

coupPossible(Gamestate,ListResult):-
	Gamestate = [Tete|Queue],

	%on test si la colonne EST remplie
	length(Tete,Taille) , not(Taille <6),

	%si test reussi (true)
	%on ajoute rien et on passe à la suite
	coupPossible(Queue,ListResult).




% ------------ partieAleatoire
partieAleatoire :-
	partieAleatoire(x).

partieAleatoire(Pion) :-
	iaRandom(Pion),
	afficherGrille,
	testGagner(Pion). 

testGagner(Pion) :-
	sh(Pion), 
	!, 
	write(Pion), write(' a gagné horizontalement'),
	finPartie.

testGagner(Pion) :-
	sv(Pion),
	!,
	write(Pion), write(' a gagné verticalement'),
	finPartie.

testGagner(Pion) :-
    sd(Pion),
    !,
    write(Pion), write(' a gagné diagonalement'),
    finPartie.

testGagner(Pion) :-
	(not(sv(Pion)), not(sh(Pion)), not(sd(Pion))),
	!,
	changerPion(Pion, Adversaire), partieAleatoire(Adversaire).


%---------- partie 2 joueurs 
partie2Joueurs :-
	partie2Joueurs(x).

partie2Joueurs(Pion) :-
	write(Pion), write(' à votre tour : '),
	read(Colonne),
	jouer(Pion, Colonne),
	afficherGrille,
	testGagner2Joueurs(Pion).
	
testGagner2Joueurs(Pion) :-
	sh(Pion), 
	!, 
	write(Pion), write(' a gagné horizontalement'),
	finPartie.
	
testGagner2Joueurs(Pion) :-
	sv(Pion),
	!,
	write(Pion), write(' a gagné verticalement'),
	finPartie.

testGagner2Joueurs(Pion) :-
    sd(Pion),
    !,
    write(Pion), write(' a gagné diagonalement'),
    finPartie.
	
testGagner2Joueurs(Pion) :-
	(not(sv(Pion)), not(sh(Pion)), not(sd(Pion))),
	!,
	changerPion(Pion, Adversaire), partie2Joueurs(Adversaire).
	
finPartie :-
	retract(gamestate(X)) , assert(gamestate([[],[],[],[],[],[],[]])).
		
changerPion(x, NouveauPion) :-
	NouveauPion = o.

changerPion(o, NouveauPion) :-
	NouveauPion = x.
