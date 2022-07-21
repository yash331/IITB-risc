library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity RAM is
	generic(
		word_length: integer := 16;
		num_words: integer := 65536);
	port(
		 RAM_DATA_IN: in std_logic_vector(word_length-1 downto 0); -- Data to write into RAM
		 --RAM_CLOCK: in std_logic; -- clock input for RAM
		 RAM_DATA_OUT: out std_logic_vector(word_length-1 downto 0); -- Data output of RAM
		 RAM_ADDR: in std_logic_vector(word_length-1 downto 0); -- Address to write/read RAM
		 clk, wr_ena, rd_ena, reset: in std_logic -- Write enable 
		);
end entity RAM;

architecture Behavioral of RAM is
	-- define the new type for the 128x8 RAM 
	type RAM_ARRAY is array (num_words-1 downto 0) of std_logic_vector (word_length-1 downto 0);
	-- initial values in the RAM
	signal memory: RAM_ARRAY;
	-- signal memory: RAM_ARRAY :=(
	--    x"55",x"66",x"77",x"67",-- 0x00: 
	--    x"99",x"00",x"00",x"11",-- 0x04: 
	--    x"00",x"00",x"00",x"00",-- 0x08: 
	--    x"00",x"00",x"00",x"00",-- 0x0C: 
	--    x"00",x"00",x"00",x"00",-- 0x10: 
	--    x"00",x"00",x"00",x"00",-- 0x14: 
	--    x"00",x"00",x"00",x"00",-- 0x18: 
	--    x"00",x"00",x"00",x"00",-- 0x1C: 
	--    x"00",x"00",x"00",x"00",-- 0x20: 
	--    x"00",x"00",x"00",x"00",-- 0x24: 
	--    x"00",x"00",x"00",x"00",-- 0x28: 
	--    x"00",x"00",x"00",x"00",-- 0x2C: 
	--    x"00",x"00",x"00",x"00",-- 0x30: 
	--    x"00",x"00",x"00",x"00",-- 0x34: 
	--    x"00",x"00",x"00",x"00",-- 0x38: 
	--    x"00",x"00",x"00",x"00",-- 0x3C: 
	--    x"00",x"00",x"00",x"00",-- 0x40: 
	--    x"00",x"00",x"00",x"00",-- 0x44: 
	--    x"00",x"00",x"00",x"00",-- 0x48: 
	--    x"00",x"00",x"00",x"00",-- 0x4C: 
	--    x"00",x"00",x"00",x"00",-- 0x50: 
	--    x"00",x"00",x"00",x"00",-- 0x54: 
	--    x"00",x"00",x"00",x"00",-- 0x58: 
	--    x"00",x"00",x"00",x"00",-- 0x5C: 
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",-- 0x7C:
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",-- 0x9C:
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",-- 0XBC
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",-- 0xDC
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",
	--    x"00",x"00",x"00",x"00",-- 0xFC
	--   ); 
	begin
		process(clk)
		begin
		 if(rising_edge(clk)) then
		 	if(wr_ena='1') then -- when write enable = 1, 
		 	-- write input data into RAM at the provided address
		 	memory(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;
		 	-- The index of the RAM array type needs to be integer so
		 	-- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
		 	end if;
		 end if;
	end process;
	 -- Data to be read out 
	RAM_DATA_OUT <= memory(to_integer(unsigned(RAM_ADDR)));
end architecture Behavioral;