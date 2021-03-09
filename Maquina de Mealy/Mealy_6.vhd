--10M50DAF484C7G

library ieee;
use ieee.std_logic_1164.all;

entity Mealy_6 is
--Secuecnia a reconocer 1011
	port(
		Entrada: in std_logic; --Revisa el bit de entrada
		CLK: in std_logic; --Clock
		Salida: out std_logic --Envia la salida si esta la secuencia	
		);
end Mealy_6;

architecture behavior of Mealy_6 is
	Type state_type is (A,B,C,D);
	signal estado: state_type; 
	signal CLKO: std_logic;
	
	Component divisor is --Insertamos Componente Divisor
		generic(
			pulsos: Integer := 25000000 --1S
		);
		port(
			CLK: in std_logic;
			CLKout: out std_logic
		);
	end component;
	

begin
	U0: divisor generic map(25000000)
		port map(CLK, CLKO); --Componente con entrada generica
		
	process(Entrada, CLKO)
	begin
		if rising_edge(CLKO) then
		-------------------------------------------------------
			case estado is
				when A =>
					if Entrada = '0' then --Entrada 0 quedate en A
						estado <= A; 
					else --Entrada en 1 ve a B
						estado <= B; 
					end if;
				when B =>
					if Entrada = '0' then --Entrada 0 ve a A
						estado <= A; 
					else --Entrada en 1 ve a C
						estado <= C; 
					end if;
				when C =>
					if Entrada = '0' then --Entrada 0 ve a C
						estado <= D; 
					else --Entrada en 1 ve a B
						estado <= B; 
					end if;
				when D =>
					if Entrada = '0' then --Entrada 0 ve a A
						estado <= A; 
					else --Entrada en 1 ve a B
						estado <= B; 
					end if;
				when others =>
					estado <= A;
			end case;
		--------------------------------------------------------
		end if; 
	end process;
	
	Salida <= '1' when ((estado = D) and (Entrada = '1')) else '0';

	
end behavior;
