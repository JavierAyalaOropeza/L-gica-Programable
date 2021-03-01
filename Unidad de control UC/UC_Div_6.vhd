library ieee;
use ieee.std_logic_1164.all;

entity Divisor is --Divisor de frecuencia

	generic(
		pulsos: integer := 25000000 --Valor generico de entrada
	);
	
	port(
		CLK: in std_logic; --Reloj de entrada
		CLKout: out std_logic --Reloj de salida
	);
end Divisor;

architecture behavior of Divisor is
	signal reloj: std_logic;
begin
	process(CLK) --Proceso sensible a cambio de reloj de entrada
	variable cont: integer;
	begin
		if(rising_edge(CLK))then
			cont := cont+1; --Cada de cambie el reloj aumenta el contador
			if(cont = pulsos) then
				reloj <= not reloj; --Señal para el cambio del reloj de salida
				cont := 0; --Reinicia el contador a cero
			end if;
		end if;
	end process;

	CLKout <= reloj; --Asigna el valor de reloj a CLKout
	
end behavior;