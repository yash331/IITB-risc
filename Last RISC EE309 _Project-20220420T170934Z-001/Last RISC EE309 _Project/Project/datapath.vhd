library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.all;

entity datapath is
	port(
	    clk, reset: in std_logic;
	    cw: in std_logic_vector(28 downto 0);
		 opcode : out std_logic_vector(3 downto 0);
		 cnd : out std_logic_vector(1 downto 0);
		 flags: out std_logic_vector(3 downto 0)
    );
end entity;

architecture struct of datapath is

    component B is
        port(
            input : in std_logic_vector(7 downto 0);
            B_write_ena: in std_logic;
				clk: in std_logic;
            output: out std_logic_vector(7 downto 0)
        );
    end component;

    component T1 is
        port(
            input : in std_logic_vector(15 downto 0);
            T_write_ena: in std_logic;
				clk: in std_logic;
            output: out std_logic_vector(15 downto 0)
        );
    end component;

    component T4 is
        port(
            input : in std_logic_vector(2 downto 0);
            T4_write_ena: in std_logic;
				clk: in std_logic;
            output: out std_logic_vector(2 downto 0)
        );
    end component;

    component T2 is
        port(
            input : in std_logic_vector(7 downto 0);
            T2_write_ena: in std_logic;
				clk: in std_logic;
            output: out std_logic_vector(7 downto 0)
        );
    end component;

    component T3 is
        port(
            input : in std_logic_vector(15 downto 0);
            T3_write_ena: in std_logic;
				clk: in std_logic;
            output: out std_logic_vector(15 downto 0)
        );
    end component;

    component RAM is
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
    end component;


    component ROM is
        generic(rom_size: integer := 65536;
            instr_size: integer := 16);
        port(
            address: in std_logic_vector(15 downto 0);
            instr_out: out std_logic_vector(instr_size-1 downto 0);
            read_enbl ,clk : in std_logic);   -------------
    end component;

    component shifter_7left is

        generic (
            input_len: integer:= 16;
            output_len: integer:= 16
        );
    
        port (
            input: in std_logic_vector(input_len-1 downto 0);
            output: out std_logic_vector(output_len-1 downto 0)
        );
    
    end component;

    component shifter_1left is

        generic (
            input_len: integer:= 16;
            output_len: integer:= 16
        );
    
        port (
            input: in std_logic_vector(input_len-1 downto 0);
            output: out std_logic_vector(output_len-1 downto 0)
        );
    
    end component;

    component shifter_1right is

        generic (
            input_len: integer:= 8;
            output_len: integer:= 8
        );
    
        port (
            input: in std_logic_vector(input_len-1 downto 0);
            output: out std_logic_vector(output_len-1 downto 0)
        );
    
    end component;

    component sign_extend_916 is
        generic(input_width: integer := 9;
            output_width: integer := 16);
        port(
            input: in std_logic_vector(input_width-1 downto 0);
            output: out std_logic_vector(output_width-1 downto 0));
    end component;

    component sign_extend_616 is
        generic(input_width: integer := 6;
            output_width: integer := 16);
        port(
            input: in std_logic_vector(input_width-1 downto 0);
            output: out std_logic_vector(output_width-1 downto 0));
    end component;

    component alu_beh is
        generic(
            operand_width : integer:=16;
            sel_line : integer:=2);
        port (
            A: in std_logic_vector(operand_width-1 downto 0);
            B: in std_logic_vector(operand_width-1 downto 0);
            Cin: in std_logic_vector(0 downto 0);
            sel: in std_logic_vector(sel_line-1 downto 0);
            op: out std_logic_vector(operand_width-1 downto 0);
            Cout: out std_logic;
            Z: out std_logic_vector(0 downto 0)
        ) ;
    end component;

    component reg_file is
  
        port (
          rf_a1 : in std_logic_vector(2 downto 0);
          rf_a2 : in std_logic_vector(2 downto 0);
          rf_a3 : in std_logic_vector(2 downto 0);
          rf_d1 : out std_logic_vector(15 downto 0);
          rf_d2 : out std_logic_vector(15 downto 0);
          rf_d3 : in std_logic_vector(15 downto 0);
          rf_d3_read_enable : in std_logic_vector(0 downto 0);
			 clk : in std_logic
        );
          
    end component;

    component mux_4X1_3bit is
        generic(
            operand_width : integer:=3;
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
    end component;

    component mux_4X1_16bit is
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
    end component;

    component mux_2X1_16bit is
        generic(
            operand_width : integer:=16;
            sel_line : integer:=1
            );
        port (
            A: in std_logic_vector(operand_width-1 downto 0);
            B: in std_logic_vector(operand_width-1 downto 0);
            sel: in std_logic_vector(sel_line-1 downto 0);
            op: out std_logic_vector(operand_width-1 downto 0)
        ) ;
    end component;

    component mux_2X1_8bit is
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
    end component;

    component IR is
	
	port(
		clk, ena, clr: in std_logic;
		Din: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0));
	end component;

    component INC is
        port(
            input : in std_logic_vector(2 downto 0);
            output: out std_logic_vector(2 downto 0);
				T4Z: out std_logic
        );
    end component;

    signal D1out, D2out, m4out, shifter_1left_out,shifter_7left_out, maout, mbout, aluout, Tout, n3out, T3out, n2out, data_mem_out, instr_mem_out, SE916_out, SE616_out, IR_out: std_logic_vector(15 downto 0);
    signal I11_9_out, I8_6_out, I5_3_out, m1out, m2out, m3out, T4out, INCout, INCin, T4in: std_logic_vector(2 downto 0);
    signal I8_0_out: std_logic_vector(8 downto 0);
    signal I7_0_out, n1out, T2out, srout, Bout: std_logic_vector(7 downto 0);
    signal I5_0_out: std_logic_vector(5 downto 0);
	 signal a, c, d, tf : std_logic;

	 
begin
	
    INSTR_MEM: ROM port map (
        address => D1out,
        instr_out => instr_mem_out,
        clk => clk,
        read_enbl => cw(24)
    );

    INSTR_REG: IR port map(
        Din => instr_mem_out,
        Dout => IR_out,
        clk => clk,
		  clr => reset,
		  ena => cw(25)
    );

    M1: mux_4X1_3bit port map(
            A => "111",
            B => IR_out(11 downto 9),
            C => IR_out(8 downto 6),
            D => m1out,
            sel(0) => cw(0),
				sel(1) => cw(1),
            op => m1out
    );

    M2: mux_4X1_3bit port map(
            A => IR_out(8 downto 6),
            B => IR_out(11 downto 9),
            C => T4out,
            D => m2out,
            sel(0) => cw(2),
				sel(1) => cw(3),
            op => m2out
    );

    M3: mux_4X1_3bit port map(
            A => IR_out(11 downto 9),
            B => IR_out(5 downto 3),
            C => "111",
            D => T4out,
            sel(0) => cw(4),
				sel(1) => cw(5),
            op => m3out
    );

    RF: reg_file port map(
          rf_a1 => m1out,
          rf_a2 => m2out,
          rf_a3 => m3out,
          rf_d1 => D1out,
          rf_d2 => D2out,
          rf_d3 => m4out,
          rf_d3_read_enable(0) => CW(8),
			 clk => clk
    );

    M4: mux_4X1_16bit port map(
            A => data_mem_out,
            B => Tout,
            C => shifter_7left_out,
            D => D2out,
            sel(0) => cw(6),
				sel(1) => cw(7),
            op => m4out
    );

    MA: mux_4X1_16bit port map(
            A => SE616_out,
            B => T3out,
            C => D1out,
            D => SE916_out,
            sel(0) => cw(9),
				sel(1) => cw(10),
            op => maout
    );


    MB: mux_4X1_16bit port map(
            A => D1out,
            B => "0000000000000001",
            C => D2out,
            D => shifter_1left_out,
            sel(0) => cw(12),
				sel(1) => cw(13),
            op => mbout
    );

    alu: alu_beh port map (
            A => maout,
            B => mbout,
				Cin => "0",  --note
				sel => "00",
				Cout => a,
				Z(0) => c,
				op => aluout
    );

    Temp1: T1 port map(
            input => aluout,
            T_write_ena => cw(18),
				clk => clk,
            output => Tout
    );

    Temp3: T3 port map(
            input => n3out,
            T3_write_ena => cw(20),
				clk => clk,
            output => T3out
    );

    n3: mux_2X1_16bit port map(
            A => Tout,
            B => D1out,
            sel(0) => cw(17),
            op => n3out
    );

    DATA_MEM: RAM port map(
                RAM_DATA_IN => D2out,
                RAM_DATA_OUT => data_mem_out,
                RAM_ADDR => n2out,
                clk => clk,
                wr_ena => cw(22),
                rd_ena => cw(23), 
                reset => reset
    );

    n2: mux_2X1_16bit port map(
            A => Tout,
            B => T3out,
            sel(0) => cw(16),
            op => n2out
    );

    Temp4: T4 port map(
            input => T4in,
            T4_write_ena => cw(21),
				clk => clk,
            output => T4out
    );

    incrementor: INC port map(
            input => INCin,
            output => INCout,
				T4Z => d
    );

    Temp2: T2 port map(
            input => n1out,
            T2_write_ena => cw(19),
				clk => clk,
            output => T2out
    );

    shiftright: shifter_1right port map(
            input => T2out,
            output => srout
    );

    Buff: B port map(
            input => srout,
            B_write_ena => cw(28),
				clk => clk,
            output => Bout
    );

    n1: mux_2X1_8bit port map(
            A => I7_0_out,
            B => Bout,
            sel(0) => cw(15),
            op => n1out
    );

    SE616: sign_extend_6_16 port map(
            input => IR_out(5 downto 0), 
            output => SE616_out
    );

    SE919: sign_extend_9_16 port map(
            input => IR_out(8 downto 0),
            output => SE916_out
    );

    shift_7left: shifter_7left port map(
            input => SE916_out,
            output => shifter_7left_out
    );
	 
	 shift_1left: shifter_1left port map(
            input => D2out,
            output => shifter_1left_out
    );
	 abdc: process(CW)
	 begin
	 if(CW(27) = '1') then INCin <= T4out;
	 end if;
	 
	 if(CW(26) = '1') then T4in <= INCout;
	 end if;

	 end process;
end architecture;