--ALU
--Javier Ayala Oropeza
--A01652711

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
--Librerias

Entity TB_ALU is --Entidad de simulacion
end TB_ALU;

Architecture behavior of TB_ALU is

	--Agrego el componente Mux previamente creado	
	Component ALU is
		port(
		A,B: in std_logic_vector (3 downto 0); --Vectores de entrada
		I: in std_logic_vector (1 downto 0); --Vector de selección
		D1: out std_logic_vector (7 downto 0);  --Vector de salida hacia el 7 segmentos
		O: out std_logic --Bit de overflow
 	);
end component;
	
	--Entradas de la entidad ALU tipo vector
	signal ASim,BSim: std_logic_vector (3 downto 0);
	signal ISim: std_logic_vector (1 downto 0);
	
	--Salidas de la entidad
	signal D1Sim: std_logic_vector (7 downto 0);
	signal OSim: std_logic;
	
begin
	UUT: ALU port map (ASim,BSim,ISim,D1Sim,OSim);
	
	stimulus: process
	begin
	
	--wait for reset
	wait for 100 ns;	
	
	
	--different stimulus here	
	ASim <="1111";
	BSim <="0011";
	ISim <= "00";
	wait for 10 ns;
	
	ASim <="1110";
	BSim <="0001";
	ISim <= "01";
	wait for 10 ns;
	
	ASim <="0010";
	BSim <="0111";
	ISim <= "01";
	wait for 10 ns;
	
	ASim <="0101";
	BSim <="1010";
	ISim <= "10";
	wait for 10 ns;
	
	ASim <="1110";
	BSim <="0011";
	ISim <= "11";
	wait for 10 ns;

	
end process;
end behavior;