--ALU
--Javier Ayala Oropeza
--A01652711

library ieee;
use ieee.std_logic_1164.all;


Entity Sumador is
	port( C,D: in std_logic_vector (3 downto 0); --Vectores de entrada C y D
			E: out std_logic_vector (3 downto 0); --Vector de salida E
			M: in std_logic; --Acarreo
			F: out std_logic -- Carry
	);
end Sumador;


Architecture behavior of Sumador is
--Agregar full_adder

	component full_adder is
	port(A, B, Cin: in std_logic;
		  Cout, S: out std_logic);
	end component;

	signal X1, X2, X3 : std_logic;
	
begin
	U0: full_adder port map (C(0),D(0),M,X1,E(0));
	U1: full_adder port map (C(1),D(1),X1,X2,E(1));
	U2: full_adder port map (C(2),D(2),X2,X3,E(2));
	U3: full_adder port map (C(3),D(3),x3,F,E(3));
end behavior;
