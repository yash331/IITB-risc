library ieee;
use ieee.std_logic_1164.all;
library work;
use work.all;

entity INC is
    port(
        input : in std_logic_vector(2 downto 0);
        output: out std_logic_vector(2 downto 0);
		  T4Z : out std_logic 
    );
end entity;


architecture simple of INC is
    signal s1, s2, s3: std_logic;
    signal temp: std_logic_vector(2 downto 0);

    component fulladder  is
        port (A, B, Cin: in std_logic; S, Cout: out std_logic);
      end component;

begin

	 
    F1: fulladder port map(A => input(0), B => '0', Cin => '1', S => temp(0), Cout => s1);
    F2: fulladder port map(A => input(1), B => s1, Cin => '0', S => temp(1), Cout => s2);
    F3: fulladder port map(A => input(2), B => s2, Cin => '0', S => temp(2), Cout => s3);
	 
	--if(temp = "111") then T4Z <= '1';
	 --else T4Z <= '0';
	 --end if;
	 T4Z <= '0';
	 
	 output <= temp;
	 

end architecture;

