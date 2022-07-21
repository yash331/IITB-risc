library ieee;
use ieee.std_logic_1164.all;

package temp_regs is 

    component T2 is
        port(
            input : in std_logic_vector(7 downto 0);
            T2_write_ena: in std_logic;
            output: out std_logic_vector(7 downto 0)
        );
    end component;

    component B is
        port(
            input : in std_logic_vector(7 downto 0);
            B_write_ena: in std_logic;
            output: out std_logic_vector(7 downto 0)
        );
    end component;

    component T4 is
        port(
            input : in std_logic_vector(2 downto 0);
            T4_write_ena: in std_logic;
            output: out std_logic_vector(2 downto 0)
        );
    end component;

    component T1 is
        port(
            input : in std_logic_vector(15 downto 0);
            T_write_ena: in std_logic;
            output: out std_logic_vector(15 downto 0)
        );
    end component;

    component T3 is
        port(
            input : in std_logic_vector(15 downto 0);
            T3_write_ena: in std_logic;
            output: out std_logic_vector(15 downto 0)
        );
    end component;

end package;


library ieee;
use ieee.std_logic_1164.all;
entity T2 is
    port(
        input : in std_logic_vector(7 downto 0);
        T2_write_ena: in std_logic;
        output: out std_logic_vector(7 downto 0)
    );
end entity;
architecture simple of T2 is
    signal s : std_logic_vector(7 downto 0);
	 begin
	 process (T2_write_ena)
begin
    if (T2_write_ena = '1') then s <= input;
    end if;
    output <= s;
	 end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity B is
    port(
        input : in std_logic_vector(7 downto 0);
        B_write_ena: in std_logic;
        output: out std_logic_vector(7 downto 0)
    );
end entity;
architecture simple of B is
    signal s : std_logic_vector(7 downto 0);
	 begin
	 process (B_write_ena)
begin
    if (B_write_ena = '1') then s <= input;
    end if;
    output <= s;
	 end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity T4 is
    port(
        input : in std_logic_vector(2 downto 0);
        T4_write_ena: in std_logic;
        output: out std_logic_vector(2 downto 0)
    );
end entity;
architecture simple of T4 is
    signal s : std_logic_vector(2 downto 0);
	 begin
	 process (T4_write_ena)
begin
    if (T4_write_ena = '1') then s <= input;
    end if;
    output <= s;
	 end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity T1 is
    port(
        input : in std_logic_vector(15 downto 0);
        T_write_ena: in std_logic;
        output: out std_logic_vector(15 downto 0)
    );
end entity;
architecture simple of T1 is
    signal s : std_logic_vector(15 downto 0);
	 begin process (T_write_ena)
begin
    if (T_write_ena = '1') then s <= input;
    end if;
    output <= s;
	 end process;
end architecture;


library ieee;
use ieee.std_logic_1164.all;
entity T3 is
    port(
        input : in std_logic_vector(15 downto 0);
        T3_write_ena: in std_logic;
        output: out std_logic_vector(15 downto 0)
    );
end entity;
architecture simple of T3 is
    signal s : std_logic_vector(15 downto 0);
	 begin process (T3_write_ena)
begin
    if (T3_write_ena = '1') then s <= input;
    end if;
    output <= s;
	 end process;
end architecture;


