--10M50DAF484C7G

library ieee;
use ieee.std_logic_1164.all;

	--------------------Estados--------------------------------
	-- Inicio							 000
	-- Fetch								 001	
	-- Decode							 010
	-- Execution						 011
	-- Memoria							 100
	-- Escritura						 101
	-- FFFFFFFF							 111	
	
	--------------------Banderas------------------------------
	-- (0) Bandera de petición a inicio
	-- (1) Bandera de cambio a inicio
	-- (2) Bandera de dirección
	-- (3) Bandera de espera del decodificador
	-- (4) Bandera de memoria
	-- (5) Bandera de espera de memoria
	-- (6) Bandera de escritura
	-- (7) Bandera de Salto
	
	--Pasos
	-----------------------------------------------------------------------------
	-- (1*) Incio -> Fetch 
	
	-----------------------------------------------------------------------------
	-- (2*) Fetch -> ¿? (Bandera de direccion)
	--            -> Fetch; 0;
	--				  -> Decode; 1;
	
	-----------------------------------------------------------------------------
	-- (3*) Decode -> ¿? (Bandera de salto), (Bandera de espera), (Bandera de peticion Inicio), (Bandera de cambio a inicio)
	--					-> Execution; 0XXX
	
	----------------------------Si hubo salto------------------------------------
	--					-> ¿? (Bandera de espera Dec), (Inicio 1), (Inicio 2) 
	
		--							-> Decode; te quedas en Decode 1100
		--							->	Inicio; 1X11;
		--				  others -> Fetch; 1XXX
	-----------------------------------------------------------------------------	
	
	--(4*) Execution -> ¿? (Bandera de memoria), (Bandera de espera M), (Bandera de escritura), (Inicio 1), (Inicio 2) 
	--					  -> Escritura; 0XXXX
	
	---------------------------Si se activo la Bandera de Memoria----------------
	--				  -> ¿? (Bandera de espera M), (Bandera de escritura), (Inicio 1), (Inicio 2) 
		--					  	-> Memoria; 1-1X00
		--						-> Escritura; 1-X100
		--						-> Inicio; 1-XX11
		-- 		  others -> Fetch; 
		
	-----------------------------------------------------------------------------
	--(5*) Memoria -> ¿? (Bandera de espera de Mem), (Bandera de escritura), (Inicio 1), (Inicio 2)
	--					-> Memoria; 1000 
	--					-> Escritura; X100
	--					-> Inicio; XX11 
	--		  others -> Fetch; 
	
	-----------------------------------------------------------------------------
	--(6*) Escritura -> ¿? (Inicio 1), (Inicio 2)
	--					  -> Inicio; 11
	--			 others -> Fetch;
	-----------------------------------------------------------------------------
	
Entity UC_6 is

	port(
		CLK: in std_logic;
		Banderas : in std_logic_vector (7 downto 0); --Vector de control para las banderas
		Dis : out std_logic_vector (6 downto 0)
		);
		
end UC_6;

architecture behavior of UC_6 is

	--Estados de la Unidad de control
	Type state_type is (Inicio, Fetch, Decode, Execution, Memoria, Escritura);
	------------------Señales--------------------------------
	signal State : state_type; --Señal de estado
	signal CLKO : std_logic; --Reloj salida
	signal Salida : std_logic_vector (2 downto 0); --Vector de salida
	
	
	-----------------------Divisor---------------------------
	Component divisor is 
	
		generic(
			pulsos: Integer := 25000000 --Valor por defecto
		);
		
		port(
			CLK: in std_logic; --CLK de entrada
			CLKout: out std_logic --CLK de salida
		);
		
	end component;
	----------------------------------------------------------	
	
	------------------------Display7--------------------------
	Component Display7 is
		port(
			IDis: in std_logic_vector (2 downto 0);	--Vector de entrada 3 bits
			D : out std_logic_vector (6 downto 0) --Display de salida derecha
		);
	end component;
	----------------------------------------------------------

begin
	
	U0: divisor generic map(25000000) --Valor que da el usario 1 segundo
			port map(CLK, CLKO); --Componente con entrada generica
	U1: Display7 port map(Salida, Dis); 
	
	process(Banderas, CLKO)
	begin 
		---------------------Maquina de estado--------------------

		if rising_edge(CLKO) then
		
			case State is
			
				when Inicio =>
						State <= Fetch; --Ve directo a inicio
						
				when Fetch =>
				--------------------------------------------
						if Banderas(2)='1' then --Bandera de dirección
							State <= Decode;
						else
							State <= Fetch; 	
						end if;	
				--------------------------------------------		
				when Decode =>
		
					if (Banderas(7) = '0') then --Bandera de salto
						State <= Execution;
					else -- Si hubo salto
					------------------------
						if ((Banderas(3) = '1') and (Banderas(1) = '0') and (Banderas(0) = '0')) then -- Bandera de D(3), Inicio 1, Inicio 2
							State <= Decode;
						elsif ((Banderas(1) = '1') and (Banderas(0) = '1')) then --	Inicio 1-X11;
							State <= Inicio;
						else 
							State <= Fetch; 
						end if;
					------------------------
					end if;

				when Execution =>

					------------------------------
					if Banderas(4)='0' then --Bandera de Memoria (4)
						State <= Escritura;
					else -- Si hubo salto
					------------------------
						if ((Banderas(5) = '1') and (Banderas(1) = '0') and (Banderas(0) = '0')) then --Banedra de Espera M (5), Bandera de escritura (6), Inicio 1 y 2
							State <= Memoria;	
						elsif ((Banderas(6) = '1') and (Banderas(1) = '0') and (Banderas(0) = '0')) then 
							State <= Escritura;
						elsif ((Banderas(1) = '1') and (Banderas(0) = '1')) then
							State <= Inicio;
						else
							State <= Fetch; 
						end if;
					------------------------
					end if;
					-------------------------------
					
				when Memoria =>
					-- Bandera de espera M(5), Bandera de escritura (6), Inicio 1 y Inicio 2
					if ((Banderas(5)= '1') and (Banderas(6) = '0') and (Banderas(1) = '0') and (Banderas(0) = '0')) then
						State <= Memoria;
					elsif ((Banderas(6) = '1') and (Banderas(1) = '0') and (Banderas(0) = '0')) then
						State <= Escritura;
					elsif (Banderas(1) = '1') and (Banderas(0) = '1') then
						State <= Inicio;
					else
						State <= Fetch; 
					end if;
					
				when Escritura =>
					if (Banderas(1) = '1') and (Banderas(0) = '1') then
						State <= Inicio; 
					else
						State <= Fetch;
					end if; 
					
			end case;
		end if;
		----------------------------------------------------------
	end process;
	
	--Definición de estados
	Salida <= "000" when (State = Inicio) else
				 "001" when (State = Fetch) else
				 "010" when (State = Decode) else
				 "011" when (State = Execution) else
				 "100" when (State = Memoria) else
				 "101" when (State = escritura) else
				 "111"; 
	
end behavior;
