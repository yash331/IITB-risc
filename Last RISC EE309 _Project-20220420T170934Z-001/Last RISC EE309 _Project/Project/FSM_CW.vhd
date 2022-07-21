library ieee;
use ieee.std_logic_1164.all;

entity fsm is
port(opcode:in std_logic_vector(3 downto 0);
     condition:in std_logic(1 downto 0); 
     reset,clock:in std_logic;
     tf, Carry_flag, Z, T4_Z: in std_logic;
	 CW: out std_logic_vector(28 downto 0)
     );
end fsm;

architecture BHV of fsm is

type state is (rst, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13 ,S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24);

signal y_present,y_next : state:= rst;

begin
clock_proc:process(clock,reset)
begin
    if(clock='1' and clock' event) then
            y_present <= y_next;
    end if;
    
end process;

Output_process:process(input, y_present)

begin
    case y_present is
	 	CW <= (others => '0');

        when S0=>
            CW(0) <= '0';
            CW(1) <= '0';
        

        when S1=>
            if(input = "001") then    
                y_next <= timer1;
                        output <= "01";
                else
                    y_next<=rst;
                    output <= "00";
                end if;
        
        when S2=>
            if(input = "001") then    
                y_next <= timer1;
                        output <= "01";
                else
                    y_next<=rst;
                    output <= "00";
                end if;

        when S3=>
            if(input = "001") then    
                y_next <= timer1;
                        output <= "01";
                else
                    y_next<=rst;
                    output <= "00";
                end if;

        when S4=>
            if(input = "001") then    
                y_next <= timer1;
                        output <= "01";
                else
                    y_next<=rst;
                    output <= "00";
                end if;
				
        
		end case;
		
end process;

Sate_transition_process:process(inp,y_present)
begin
    case y_present is

    when rst=>
        if(opcode = "1000") then y_next <= S10;
        else y_next <= S0;

    when S0=>
        case opcode is:
            when "0000" => --ADI INSTRUCTION
                y_next <= S4; 
            
            when "0001" =>  --ADD INSTRUCTIONS
                case condition is:
                 when "00" =>
                    y_next <= S1;

                 when "10" =>
                    if(Carry_flag = '1') then
                        y_next <= S1;
                    else 
                        y_next <= S13;
                 when "01" =>
                    if(Z = '1') then
                       y_next <= S1;
                    else 
                       y_next <= S13;

                 others =>
                    y_next <= S3;
                 end case;
            
            when "0010" =>  --NAND INSTRUCTIONS
                 case condition is:
                 when "00" =>
                    y_next <= S1;

                 when "10" =>
                    if(Carry_flag = '1') then
                        y_next <= S1;
                    else 
                        y_next <= S13;
                 when "01" =>
                    if(Z = '1') then
                       y_next <= S1;
                    else 
                       y_next <= S13;
                    end case;

                 when others => y_next <= rst;

            when "0100" => y_next <= S13;
            
            when "0101" | "0111" => y_next <= S7;

            when "1100" | "1101" => y_next <= S18;

            when "1000" => y_next <= rst;

            when "1001" | "1010"=> y_next <= S14;

            when "1011"=> y_next <= S17;

    
    when S1=> y_next <= S2;

    when S2=> y_next <= rst;

    when S3=> y_next <= S2;

    when S4=> y_next <= S5;

    when S5=> y_next <= rst;

    when S6=> y_next <= rst;

    when S7=> 
        case opcode is:
            when "0111"=> y_next <= S8;           
            when "0101"=> y_next <= S9;

    when S8=> y_next <= rst;
    when S9=> y_next <= rst;
    when S10=> y_next <= S11;

    when S11=> 
        if(Z = '1') then y_next <= S12;
        else y_next <= S0;

    when S12=> y_next <= S13;

    when S13=> 
        case opcode is:
            when "0100" => y_next <= S6;
            when "1000" | "1011" | "1001" => y_next <= rst;
            
    when S14=> 
        case opcode is:
            when "1001" => y_next <= S15;
            when "1010" => y_next <= S16;
            when others => --do nothing

    when S15=> y_next <= S13;

    when S16=> y_next <= rst;

    when S17=> y_next <= S13;

    when S18=> 
        if(tf = '1') then 
            if(opcode = "1100") then y_next <= S19;
            else y_next <= S24;
                    
        else y_next <= S22;

    when S19=> y_next <= S20;

    when S20=> y_next <= S21;
        
    when S21=> 
        if(T4_Z = '1') then y_next <= rst;

        else
            if(tf = '1') then
                if(opcode = "1100") then y_next <= S19;
                else y_next <= S22;

            else y_next <= S22;

    when S22=> y_next <= S23;

    when S23=> 
        if(T4_Z = '1') then y_next <= rst;

        else
            if(tf = '1') then 
                if(opcode = "1100") then y_next <= S19;
                else y_next <= S22;

            else y_next <= S22;

    when S24=> y_next <= S20;

end process;
	

end BHV;  