library ieee;
use ieee.std_logic_1164.all;
entity T4 is
    port(
        input : in std_logic_vector(2 downto 0);
		  clk: in std_logic;
        T4_write_ena: in std_logic;
        output: out std_logic_vector(2 downto 0)
    );
end entity;
architecture simple of T4 is
    signal s : std_logic_vector(2 downto 0);
	 begin
	 process (T4_write_ena)
begin
    if (clk'event and clk = '1') then 
			if(T4_write_ena = '1') then s <= input;
			end if;
    end if;
    output <= s;
	 end process;
end architecture;