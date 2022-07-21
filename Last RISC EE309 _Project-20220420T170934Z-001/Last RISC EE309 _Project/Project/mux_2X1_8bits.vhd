library ieee;
use ieee.std_logic_1164.all;
library ieee;

entity mux_2X1_8bit is
    generic(
        operand_width : integer:=8;
        sel_line : integer:=1
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
        sel: in std_logic_vector(sel_line-1 downto 0);
        op: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end mux_2X1_8bit;

architecture simple of mux_2X1_8bit is
    begin process(sel)
begin

    if (sel = "0") then op <= A;
    else op <= B;
	 end if;
end process;
end architecture;