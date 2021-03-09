library ieee;
use ieee.std_logic_1164.all;

entity FSM_Moore is
port (
		p, clk, Reset: in std_logic;
		R: out std_logic
);
end FSM_Moore;

architecture behav of FSM_Moore is

	TYPE state_type is (A,B,C,D);
	signal estadito: state_type;
	signal divi: std_logic;
	
	Component divisor is --Insertamos Componente Divisor
		generic(
			pulsos: Integer := 25000000
		);
		port(
			CLK: in std_logic;
			CLKout: out std_logic
		);
	end component;
	
begin
	--
	U0: divisor generic map(25000000)
		port map(clk, divi); --Componente con entrada generica
					 
	process(divi,p)
	begin
		if (Reset='1') then
			estadito<=A;
		elsif rising_edge(divi) then
			--intrucciones para cambiar de estado
			CASE estadito IS
				when A =>
					if p='1' then
						estadito<=B;
					end if;	
				When B =>
					if p='1' then
						estadito<=C;
					end if;
				When C =>
					if p='1' then
						estadito<=D;
					end if;
				When D =>
					if p='1' then
						estadito<=B;
					else
						estadito <=A;
					end if;
				When others=>
					estadito<=A;
			end case;	
		end if;
	end process;

	--Secuencial utilizando Case
-----------------------------------
--	process(estadito)
--	begin
--		case estadito is
--			when D=>
--				R <='1';
--			when others =>
--				R <= '0';
--		end case; 
--	end process;
------------------------------------
	
	-- Concurente	
	R <= '1' when estadito = D else '0'; --Salida
	
end behav;