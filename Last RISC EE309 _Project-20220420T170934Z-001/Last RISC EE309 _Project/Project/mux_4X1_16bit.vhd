library ieee;
use ieee.std_logic_1164.all;

entity mux_4X1_16bit is
    generic(
        operand_width : integer:=16;
        sel_line : integer:=2
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
		  C: in std_logic_vector(operand_width-1 downto 0);
		  D: in std_logic_vector(operand_width-1 downto 0);
        sel: in std_logic_vector(sel_line-1 downto 0);
        op: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end mux_4X1_16bit;

architecture Struct of mux_4X1_16bit is

-------------------------functions


begin 

mux : process(A, B, C, D, sel)  
-------------------------variables

begin

---------------------------code
op(15) <= ((not(sel(1)))and(not(sel(0)))and(A(15))) or ((not(sel(1)))and(sel(0))and(B(15))) or ((not(sel(0)))and(sel(1))and(C(15))) or ((sel(1))and(sel(0))and(D(15))) ;
op(14) <= ((not(sel(1)))and(not(sel(0)))and(A(14))) or ((not(sel(1)))and(sel(0))and(B(14))) or ((not(sel(0)))and(sel(1))and(C(14))) or ((sel(1))and(sel(0))and(D(14))) ;
op(13) <= ((not(sel(1)))and(not(sel(0)))and(A(13))) or ((not(sel(1)))and(sel(0))and(B(13))) or ((not(sel(0)))and(sel(1))and(C(13))) or ((sel(1))and(sel(0))and(D(13))) ;
op(12) <= ((not(sel(1)))and(not(sel(0)))and(A(12))) or ((not(sel(1)))and(sel(0))and(B(12))) or ((not(sel(0)))and(sel(1))and(C(12))) or ((sel(1))and(sel(0))and(D(12))) ;
op(11) <= ((not(sel(1)))and(not(sel(0)))and(A(11))) or ((not(sel(1)))and(sel(0))and(B(11))) or ((not(sel(0)))and(sel(1))and(C(11))) or ((sel(1))and(sel(0))and(D(11))) ;
op(10) <= ((not(sel(1)))and(not(sel(0)))and(A(10))) or ((not(sel(1)))and(sel(0))and(B(10))) or ((not(sel(0)))and(sel(1))and(C(10))) or ((sel(1))and(sel(0))and(D(10))) ;
op(9) <= ((not(sel(1)))and(not(sel(0)))and(A(9))) or ((not(sel(1)))and(sel(0))and(B(9))) or ((not(sel(0)))and(sel(1))and(C(9))) or ((sel(1))and(sel(0))and(D(9))) ;
op(8) <= ((not(sel(1)))and(not(sel(0)))and(A(8))) or ((not(sel(1)))and(sel(0))and(B(8))) or ((not(sel(0)))and(sel(1))and(C(8))) or ((sel(1))and(sel(0))and(D(8))) ;
op(7) <= ((not(sel(1)))and(not(sel(0)))and(A(7))) or ((not(sel(1)))and(sel(0))and(B(7))) or ((not(sel(0)))and(sel(1))and(C(7))) or ((sel(1))and(sel(0))and(D(7))) ;
op(6) <= ((not(sel(1)))and(not(sel(0)))and(A(6))) or ((not(sel(1)))and(sel(0))and(B(6))) or ((not(sel(0)))and(sel(1))and(C(6))) or ((sel(1))and(sel(0))and(D(6))) ;
op(5) <= ((not(sel(1)))and(not(sel(0)))and(A(5))) or ((not(sel(1)))and(sel(0))and(B(5))) or ((not(sel(0)))and(sel(1))and(C(5))) or ((sel(1))and(sel(0))and(D(5))) ;
op(4) <= ((not(sel(1)))and(not(sel(0)))and(A(4))) or ((not(sel(1)))and(sel(0))and(B(4))) or ((not(sel(0)))and(sel(1))and(C(4))) or ((sel(1))and(sel(0))and(D(4))) ;
op(3) <= ((not(sel(1)))and(not(sel(0)))and(A(3))) or ((not(sel(1)))and(sel(0))and(B(3))) or ((not(sel(0)))and(sel(1))and(C(3))) or ((sel(1))and(sel(0))and(D(3))) ; 
op(2) <= ((not(sel(1)))and(not(sel(0)))and(A(2))) or ((not(sel(1)))and(sel(0))and(B(2))) or ((not(sel(0)))and(sel(1))and(C(2))) or ((sel(1))and(sel(0))and(D(2))) ;
op(1) <= ((not(sel(1)))and(not(sel(0)))and(A(1))) or ((not(sel(1)))and(sel(0))and(B(1))) or ((not(sel(0)))and(sel(1))and(C(1))) or ((sel(1))and(sel(0))and(D(1))) ;
op(0) <= ((not(sel(1)))and(not(sel(0)))and(A(0))) or ((not(sel(1)))and(sel(0))and(B(0))) or ((not(sel(0)))and(sel(1))and(C(0))) or ((sel(1))and(sel(0))and(D(0))) ;

end process;


end Struct;