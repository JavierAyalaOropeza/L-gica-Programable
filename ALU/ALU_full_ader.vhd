--ALU
--Javier Ayala Oropeza
--A01652711

library ieee;
use ieee.std_logic_1164.all;


Entity full_adder is
	port(A,B,Cin: in std_logic;
		  Cout, S: out std_logic);
end full_adder;

Architecture behavior of full_adder is
	component half_adder is
		port(A,B			: in std_logic;
			  sum, carry: out std_logic);
	end component;

	signal C1, S1, C2 : std_logic;
	
begin
	U0: half_adder port map (A,B,S1,C1);
	U1: half_adder port map (S1,Cin,S,C2);
	Cout <= C1 or C2;
end behavior;
