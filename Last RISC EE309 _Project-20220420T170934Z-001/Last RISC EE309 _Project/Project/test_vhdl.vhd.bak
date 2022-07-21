library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.textio.all ;
--use ieee.std_logic_textio.all; -- to compile add option --ieee=synopsys

entity test_final is
end entity;

architecture test of test_final is
    component IITB_RISC is
        port(
        reset, clk: in std_logic);
    end component;
    signal clk, reset: std_logic := '0';
begin
    process
    begin
        wait for 10 ns;
        clk <= not clk;
		report "Switch" severity note;
    end process;
    
    process
    begin
        reset <= '1';
        wait until (clk = '1');
        wait until (clk = '1');
        reset <= '0';
        wait;
    end process;

    risc_instance: IITB_RISC
    port map(reset => reset, clk => clk);
    
end architecture;