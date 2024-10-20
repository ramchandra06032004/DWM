
%code of family tree

p(ramchandra,bharat).
p(bharat,raju).
p(bharat,rhutik).
p(shabbir,hasan).
p(rakesh,vishvesh).

g(X,Y):-
    p(X,Z),
    p(Z,Y).

sib(X,Y):-
    p(Z,X),
    p(Z,Y).



%code of factorial


% Base case: factorial of 0 is 1.
fact(0, 1).

% Recursive case: factorial of A is A * factorial of (A-1).
fact(A, B) :-
    A > 0,
    A1 is A - 1,
    fact(A1, B1),
    B is A * B1.








%code of gcd and lcm
gcd(A,0,A) :- A>0.

gcd(A,B,G) :-
    B>0,
    C is A mod B,
    gcd(B,C,G).

lcm(A,B,LCM) :-
    gcd(A,B,GCD),
    LCM is A*B//GCD.
