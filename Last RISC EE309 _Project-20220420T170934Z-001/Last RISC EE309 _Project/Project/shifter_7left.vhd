library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter_7left is

    generic (
        input_len: integer:= 16;
        output_len: integer:= 16
    );

    port (
        input: in std_logic_vector(input_len-1 downto 0);
        output: out std_logic_vector(output_len-1 downto 0)
    );

end shifter_7left;

architecture simple of shifter_7left is

    begin
    shift : process(input)
        begin
            output(15) <= input(8);
            output(14) <= input(7);
            for i in 0 to 6 loop
                output(i+7) <= input(i);
                output(i) <= '0';
            end loop;
        end process;
    end architecture simple;



    