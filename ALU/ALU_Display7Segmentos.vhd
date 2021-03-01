--ALU
--Javier Ayala Oropeza
--A01652711

library ieee;
use ieee.std_logic_1164.all;

Entity Display7 is
	port(
		IDis: in std_logic_vector (3 downto 0);	--Vector de entrada	
		ODis: out std_logic_vector (7 downto 0)   --Vector de salida
	);
end Display7;

Architecture behavior of Display7 is
begin
	process (IDis) 
	begin
		Case IDis is
			when "0000" =>
				ODis <= not("00111111");
			when "0001" =>
				ODis <= not("00000110");
			when "0010" =>
				ODis <= not("01011011");
			when "0011" =>
				ODis <= not("01001111");
			when "0100" =>
				ODis <= not("01100110"); --4
			when "0101" =>
				ODis <= not("01101101"); --5
			when "0110" =>
				ODis <= not("01111101"); --6
			when "0111" =>
				ODis <= not("00000111"); --7
			when "1000" =>
				ODis <= not("01111111"); --8
			when "1001" =>
				ODis <= not("01100111"); --9
			when "1010" =>
				ODis <= not("01110111"); --A
			when "1011" =>
				ODis <= not("01111100"); --B
			when "1100" =>
				ODis <= not("00111001"); --C
			when "1101" =>
				ODis <= not("01011110"); --D
			when "1110" =>
				ODis <= not("01111001"); --E
			when "1111" =>
				ODis <= not("01110001"); --F
			when others =>
				ODis <= not("00111111"); --0
		end case;
	end process;
end behavior; 