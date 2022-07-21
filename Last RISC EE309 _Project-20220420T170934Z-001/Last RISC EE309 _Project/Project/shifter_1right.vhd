library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter_1right is

    generic (
        input_len: integer:= 8;
        output_len: integer:= 8
    );

    port (
        input: in std_logic_vector(input_len-1 downto 0);
        output: out std_logic_vector(output_len-1 downto 0)
    );

end shifter_1right;

architecture simple of shifter_1right is

    begin
    shift : process(input)
        begin
            output(7) <= '0';
            for i in 0 to 6 loop
                output(i) <= input(i+1);
            end loop;
        end process;
    end architecture simple;