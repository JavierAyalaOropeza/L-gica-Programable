--ALU
--Javier Ayala Oropeza
--A01652711

library ieee;
use ieee.std_logic_1164.all;

Entity TB_Sumador is
end TB_Sumador;


Architecture behavior of TB_Sumador is

	Component Sumador is
	port( C,D: in std_logic_vector (3 downto 0); --Vectores de entrada C y D
			E: out std_logic_vector (3 downto 0); --Vector de salida E
			M: in std_logic; --Entrada Acarreo
			F: out std_logic -- Carry
	);
	end component;
	
	--Inputs Entidad
	signal CSim, DSim: std_logic_vector (3 downto 0);
	signal ESim: std_logic_vector (3 downto 0); --Vector de salida E
	signal MSim: std_logic;
	Signal FSim: std_logic; -- Carry
	
	
begin
	UUT: Sumador port map (CSim,DSim, ESim, MSim,FSim);
	
	stimulus: process
	begin
	
	--wait for reset
	wait for 100 ns;
	
	--different stimulus here	
	CSim <= "0010";
	DSim <= "1110";
	MSim <= '1';
	wait for 20 ns;
	
	CSim <= "0000";
	DSim <= "0001";
	MSim <= '0';
	wait for 20 ns;
	
end process;
 
end behavior;