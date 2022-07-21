library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee;
use ieee.std_logic_1164.all;

entity alu_beh is
    generic(
        operand_width : integer:=16;
        sel_line : integer:=2);
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
        Cin: in std_logic;
        sel: in std_logic_vector(sel_line-1 downto 0);
        op: out std_logic_vector(operand_width-1 downto 0);
        Cout: out std_logic;
        Z: out std_logic_vector(0 downto 0)
    ) ;
end alu_beh;

architecture a1 of alu_beh is

    function add(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0); cin: in std_logic)
        return std_logic_vector is
		  
				variable sum : std_logic_vector(15 downto 0) := (others => '0');
				variable carry : std_logic_vector(16 downto 0) := (others => '0');
                
            -- Declare "sum" and "carry" variable
            -- you can use aggregate to initialize the variables & signals as shown below
            --    variable variable_name : std_logic_vector(3 downto 0) := (others => '0');
				
        begin
            -- write logic for addition
            -- Hint: Use for loop
				carry(0) := Cin;
				for i in 0 to 15 loop
						sum(i) := A(i) xor B(i) xor carry(i);
						carry(i+1) := (A(i) and B(i)) or (carry(i) and (A(i) xor B(i)));
				end loop;
                Cout <= carry(16);		
            return sum;
    end add;

signal op_temp: std_logic_vector(15 downto 0);		
begin
alu : process( A, B, Cin, sel)


begin

			
	if (sel = "00") then        --ADD16				
			
            op_temp <= add(A ,B,Cin);
			
	elsif (sel = "01") then			
			
            op_temp <= A nand B;

	elsif (sel = "10") then			
			
			op_temp <= A xor B;
	end if;  

	if (to_integer(unsigned(op_temp)) = 0) then
    Z(0) <= '1';
	else Z(0) <= '0';
	end if;
	
	op <= op_temp;
   
end process ; -- alu
end a1 ; -- a1
