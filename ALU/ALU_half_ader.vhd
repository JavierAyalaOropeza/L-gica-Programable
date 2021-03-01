--ALU
--Javier Ayala Oropeza
--A01652711

library ieee;
use ieee.std_logic_1164.all;

Entity half_adder is
	port(A,B:	 in std_logic;
		sum, carry: out std_logic
	);
end half_adder;

Architecture behaviour of half_adder is
begin
	sum<= A xor B;
	carry<= A and B;
end behaviour;