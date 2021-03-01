library ieee;
use ieee.std_logic_1164.all;

--Estado 7 Segmentos
	--------------------Estados--------------------------------
	-- Inicio							 000  S
	-- Fetch								 001	F
	-- Decode							 010	D
	-- Execution						 011	E
	-- Memoria							 100	M
	-- Escritura						 101	W
	-- 00000000							 111	0
	------------------------------------------------------------
Entity Display7 is
	port(
		IDis: in std_logic_vector (2 downto 0);	--Vector de entrada 3 bits
		D : out std_logic_vector (6 downto 0) --Display de salida derecha
	);
	
end Display7;

Architecture behavior of Display7 is
begin

	process(IDis)
	begin
		case IDis is
			when "000" =>
				D <= not("1101101"); --S
			when "001" => 
				D <= not("1110001"); --F
			when "010" =>
				D <= not("1011110"); --d
			when "011"=>
				D <= not("1111001"); --E
			when "100" =>
				D <= not("0110111"); --M
			when "101" =>
				D <= not("0011101"); --W
			when others =>
				D <= not("0111111"); --0 
		end case;
	end process; 

end behavior;