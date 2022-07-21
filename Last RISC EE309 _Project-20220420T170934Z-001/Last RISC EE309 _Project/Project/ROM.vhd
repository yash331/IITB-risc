library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
	generic(rom_size: integer := 65536;
		instr_size: integer := 16);
	port(
		address: in std_logic_vector(15 downto 0);
		instr_out: out std_logic_vector(instr_size-1 downto 0);
		read_enbl ,clk : in std_logic);   -------------
end entity;

architecture behave of ROM is
	type int_array is array (0 to rom_size-1) of integer;
	signal memory: int_array := (others => 0); ------------
begin

	process(read_enbl, address)
	begin
		instr_out <= (others => 'Z');  -------------
		if(read_enbl = '1') then
			instr_out <= std_logic_vector(to_unsigned(memory(to_integer(unsigned(address))),instr_size));
		end if;
	end process;

	--memory(0) <= 33392;
	--memory(112) <= 13313;	memory(113) <= 38528;	memory(2048) <= 2976;	memory(2049) <= 8865;

end architecture;