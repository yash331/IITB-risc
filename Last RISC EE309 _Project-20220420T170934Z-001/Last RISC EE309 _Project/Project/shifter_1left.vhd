library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter_1left is

    generic (
        input_len: integer:= 16;
        output_len: integer:= 16
    );

    port (
        input: in std_logic_vector(input_len-1 downto 0);
        output: out std_logic_vector(output_len-1 downto 0)
    );

end shifter_1left;

architecture simple of shifter_1left is

    begin
    shift : process(input)
        begin
            output(0) <= '0';
            for i in 0 to 14 loop
                output(i+1) <= input(i);
            end loop;
        end process;
    end architecture simple;