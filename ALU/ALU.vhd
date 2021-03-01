--ALU
--Javier Ayala Oropeza
--A01652711

library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
--Librerias

Entity ALU is
	port(
		A,B: in std_logic_vector (3 downto 0); --Vectores de entrada
		I: in std_logic_vector (1 downto 0); --Vector de selección
		D1: out std_logic_vector (7 downto 0);  --Vector de salida hacia el 7 segmentos
		O: out std_logic --Bit de overflow 
 	);
end ALU;

Architecture behavior of ALU is

	Component Sumador is --Sumador completo de 4 bits
		port( C,D: in std_logic_vector (3 downto 0); --Vectores de entrada C y D
			E: out std_logic_vector (3 downto 0); --Vector de salida E
			M: in std_logic; --Entrada de accareo previo
			F: out std_logic -- Carry
	);
	end component;
	
	---------------------------------------------------------------------
	Component Display7 is --Display 7 segmentos
		port(
			IDis: in std_logic_vector (3 downto 0);	--Vector de entrada	
			ODis: out std_logic_vector (7 downto 0)   --Vector de salida
		);
	end component;
	---------------------------------------------------------------------
	
	signal G,H,Y,J,Z: std_logic_vector (3 downto 0);
	signal K: std_logic;
	signal L: std_logic; --Señal para la salida del Sumador
	signal Resta: std_logic := '0'; --Señal para la resta
	
begin
	process(I,A,B)
	
		begin
		
			case I is
				---------------------------------------------------------
				when "00" => --Suma de 4 bits con overflow
							G<=A; --Se agrega el vector A tal y como llego
							H<=B; --Se agrega el vector B tal y como llego
							K<='0'; --Con accareo 0
				---------------------------------------------------------	 
				when "01" => --Resta de 4 bits con overflow	
				---------------------------------------------------------
							G<=A; --Se agrega el vector A tal y como llego
							H <= (not B(3))&(not B(2))&(not B(1))&(not B(0)); --Se agrega el complemento a 1 de B
							K<='1'; --Se suma 1 para obtener el complemento a 2 y relaizar la suma
							
							------------------------------------------
								if A < B then --La suma es un numero negativo overflow
									Resta <= '1'; --Hay overflow
								else --NO hay overflow
									Resta <='0';
								end if;		
							------------------------------------------
							
				---------------------------------------------------------
				when "10" => --AND --Operación and con 4 bits
							Y <= A and B; --Se agrega el resultado a la señal Y
							Resta <='0'; --Regrega el valor de Resta al valor por defecto
				---------------------------------------------------------
				when "11" => --Operación or con 4 bits
							Y <= A or B; --Se agrega el resultado a la señal Y
							Resta <='0'; --Regrega el valor de Resta al valor por defecto
				---------------------------------------------------------
				when others =>
							Y<="0000";
			end case;
			
			
			
	end process;
	-- Define las conceciones del Sumador
	U0:Sumador port map (G,H,Z,K,L); --Conexiones del sumador
	
	
	------------------------------------------------------
	O <= L when I="00" else --Salida de Overflow en Suma
		 Resta; --Salida de Overflow en resta
	------------------------------------------------------
	
	----------------------------Mux----------------------
	
		J <= Z when (I="00" or I="01") else --Asigna el resultado de la suma
			  Y; --Lo demas
	-----------------------------------------------------
		U1: Display7 port map(J,D1);	

end behavior;