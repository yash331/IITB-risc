library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity main is
port(clk, reset: in std_logic);
end entity;

architecture simple of main is 

component fsm is
port(   reset,clock:in std_logic;
        opcode:in std_logic_vector(3 downto 0);
        condition:in std_logic_vector(1 downto 0); 
        CW: out std_logic_vector(28 downto 0);
        tf, Carry_flag, Z, T4_Z: in std_logic

        );
end component;

component datapath is
	port(
	    clk, reset: in std_logic;
	    cw: in std_logic_vector(28 downto 0);
		 opcode : out std_logic_vector(3 downto 0);
		 cnd : out std_logic_vector(1 downto 0);
		 flags: out std_logic_vector(3 downto 0)
    );
end component;

signal control: std_logic_vector(28 downto 0);
signal oc, f: std_logic_vector(3 downto 0);
signal condi: std_logic_vector(1 downto 0);

begin

fsm_1: fsm port map(
			reset => reset,
			clock => clk,
        opcode => oc,
        condition => condi,
        CW => control,
        tf => f(0), 
		  Carry_flag => f(3), 
		  Z => f(2),
		  T4_Z => f(1)
	);
	
datapath1 : datapath port map(
	    clk => clk, 
		 reset => reset,
	    cw => control,
		 opcode => oc,
		 cnd => condi,
		 flags => f
    );
	 
end architecture;