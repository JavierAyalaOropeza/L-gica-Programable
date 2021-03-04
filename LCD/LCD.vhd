library ieee;
use ieee.std_logic_1164.all;

Entity LCD is
	Port(
		DB: out std_logic_vector (7 downto 0);
		RS, RW, E: out std_logic;
		CLK_S0 : in std_logic
	);
end LCD;

architecture behvior of LCD is 
	signal CLK_Div: std_logic; 
	
	Type state_type is (s0,s1,s2,s3,s4,s5,FIN);
	signal estados : state_type;
	
begin
	--Se necesita divisor de frecuencia
	process(CLK_Div)
	begin
		If rising_edge(CLK_Div) then
			case estados is
				when S0 =>
					RS <= '0';
					RW <= '0';
					DB <= x"38";
					E <= '1'
					estados <= S1; 
				when S1 =>
					RS <= '0';
					RW <= '0';
					DB <= x"38";
					E <= '0'
					estados <= S2;
				when S2 =>
					RS <= '0';
					RW <= '0';
					DB <= x"0F";
					E <= '1'
					estados <= s3;
				when S3 =>
					RS <= '0';
					RW <= '0';
					DB <= x"0F";
					E <= '0'
					estados <= s4;
				when S4 =>
					RS <= '0';
					RW <= '0';
					DB <= x"01";
					E <= '1'
					estados <= s5;
				when S5 =>
					RS <= '0';
					RW <= '0';
					DB <= x"01";
					E <= '0'
					estados <= FIN;
				when FIN =>
					estados <= FIN;
				when others =>
					estados <= S0;
			end case;	
		end if;
	end process;
	

end behavior;