library ieee;
use ieee.std_logic_1164.all;

entity fsm is
port(   reset,clock:in std_logic;
        opcode:in std_logic_vector(3 downto 0);
        condition:in std_logic_vector(1 downto 0); 
        CW: out std_logic_vector(28 downto 0);
        tf, Carry_flag, Z, T4_Z: in std_logic

        );
end entity;

architecture BHV of fsm is

type state is (rst, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13 ,S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24);

signal y_present,y_next: state;

begin

clock_proc:process(clock, y_next)
begin
    if(clock='1' and clock'event) then
            y_present <= y_next;
    end if;
    
end process;


Output_process:process(opcode, y_present)

begin
    CW <= (others => '0');
    case y_present is 

        when rst=>
            CW <= (others => '0');
        when S0=>
            CW(0) <= '0';
            CW(1) <= '0';
            CW(14 downto 8) <= "1101010";
            CW(28 downto 18) <= "00011000001";
        when S1=>
            CW(14 downto 0) <= "101101110010010";
            CW(28 downto 18) <= "00000000001";
        when S2=>
            CW(8 downto 4) <= "11010";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00000000000";
        when S3=>
            CW(14 downto 0) <= "111101110010010";
            CW(28 downto 18) <= "00000000001";
        when S4=>
            CW(0) <= '1';
            CW(1) <= '0';
            CW(14 downto 4) <= "10010011001";
            CW(28 downto 18) <= "00000000001";
        when S5=>
            CW(8 downto 4) <= "11000";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00000000000";       
        when S6=>
            CW(8 downto 4) <= "00100";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00000000000";
        when S7=>
            CW(0) <= '1';
            CW(1) <= '0';
            CW(14 downto 4) <= "10010011001";
            CW(28 downto 18) <= "00000000001";
        when S8=>
            CW(8 downto 4) <= "10000";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(16) <= '0';
            CW(28 downto 18) <= "00000100000";
        when S9=>
            CW(2) <= '0';
            CW(3) <= '1';
            CW(8) <= '0';
            CW(11) <= '0';
            CW(14) <= '0';
            CW(16) <= '0';
            CW(28 downto 18) <= "00000010000";
        when S10=>
            CW(0) <= '0';
            CW(1) <= '0';
            CW(8) <= '0';
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00011000000";
        when S11=>
            CW(3 downto 0) <= "1001";
            CW(14 downto 8) <= "1011010";
            CW(28 downto 18) <= "00000000001";
        when S12=>
            CW(0) <= '0';
            CW(1) <= '0';
            CW(14 downto 8) <= "1001000";
            CW(28 downto 18) <= "00000000001";
        when S13=>
            CW(8 downto 4) <= "01001";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00000000000";
        when S14=>
            CW(8 downto 4) <= "01000";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00000000000";
        when S15=>
            CW(0) <= '0';
            CW(1) <= '0';
            CW(14 downto 8) <= "1001110";
            CW(28 downto 18) <= "00000000001";
        when S16=>
            CW(8 downto 2) <= "1110100";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "00000000000";
        when S17=>
            CW(0) <= '0';
            CW(1) <= '1';
            CW(14 downto 8) <= "1001110";
            CW(28 downto 18) <= "00000000001"; 
        when S18=>
            CW(0) <= '0';
            CW(1) <= '1';
            CW(8 downto 4) <= "11001";
            CW(11) <= '0';
            CW(14) <= '0';
            CW(15) <= '0';
            CW(28 downto 17) <= "000000001101";
        when S19=>
            CW(8 downto 4) <= "10011";
            CW(11) <= '0';
            CW(16 downto 14) <= "110";
            CW(28 downto 18) <= "01000100010";
        when S20=>
            CW(14 downto 8) <= "1101100";
            CW(28 downto 18) <= "10100001001";
        when S21=>
            CW(8) <= '0';
            CW(11) <= '0';
            CW(15 downto 14) <= "10";
            CW(28 downto 17) <= "000000001100";
        when S22=>
            CW(8) <= '0';
            CW(11) <= '0';
            CW(14) <= '0';
            CW(28 downto 18) <= "11000000000";
        when S23=>
            CW(8) <= '0';
            CW(11) <= '0';
            CW(15 downto 14) <= "10";
            CW(28 downto 18) <= "00100000010";
        when S24=>
            CW(3 downto 2) <= "01";
            CW(8) <= '0';
            CW(11) <= '0';
            CW(14) <= '0';
            CW(16) <= '0';
            CW(28 downto 18) <= "01000010000";
		end case;
		
end process;




--------------------------------------------------

Sate_transition_process:process(opcode, condition, y_present, tf, Carry_flag, Z, T4_Z, reset)
begin
y_next <= y_present;

if(reset = '1') then 
    y_next <= rst;

else
        
    case y_present is

        when rst=>
            if(opcode = "1000") then y_next <= S10;
            else y_next <= S0;
	    	end if;
        
        when S0=>
            case opcode is
                when "0000" => --ADI INSTRUCTION
                    y_next <= S4; 
                
                when "0001" =>  --ADD INSTRUCTIONS
                    case condition is
                        when "00" => y_next <= S1;
                    
                        when "10" =>
                            if(Carry_flag = '1') then y_next <= S1;
                            else y_next <= S13;
	    			        end if;
                        when "01" =>
                            if(Z = '1') then y_next <= S1;
                            else y_next <= S13;
	    			        end if;
                        when others =>
                            y_next <= S3;
                    end case;
                    
                when "0010" =>  --NAND INSTRUCTIONS
                    case condition is
                        when "00" => y_next <= S1;
                        when "10" =>
                            if(Carry_flag = '1') then y_next <= S1;
                            else y_next <= S13;
	    			        end if;
                        when "01" =>
                            if(Z = '1') then y_next <= S1;
                            else y_next <= S13;
	    			        end if;
                    
                        when others => y_next <= rst;
	    			end case;
                    
                when "0100" => y_next <= S13;
                    
                when "0101" | "0111" => y_next <= S7;
                    
                when "1100" | "1101" => y_next <= S18;
                    
                when "1000" => y_next <= rst;
                    
                when "1001" | "1010"=> y_next <= S14;
                    
                when "1011"=> y_next <= S17;
                    
	    		when others =>
                    
	    	end case;
                    
                    
        when S1=> y_next <= S2;
                    
        when S2=> y_next <= rst;
                    
        when S3=> y_next <= S2;
                    
        when S4=> y_next <= S5;
                    
        when S5=> y_next <= rst;
                    
        when S6=> y_next <= rst;
                    
        when S7=> 
            case opcode is
                when "0111"=> y_next <= S8;           
                when "0101"=> y_next <= S9;
	    		when others=>
	    	end case;
            
        when S8=> y_next <= rst;
        when S9=> y_next <= rst;
        when S10=> y_next <= S11;
            
        when S11=> 
            if(Z = '1') then y_next <= S12;
            else y_next <= S0;
	    	end if;
            
        when S12=> y_next <= S13;
            
        when S13=> 
            case opcode is
                when "0100" => y_next <= S6;
                when "1000" | "1011" | "1001" => y_next <= rst;
	    		when others =>
	    	end case;
                
        when S14=> 
            case opcode is
                when "1001" => y_next <= S15;
                when "1010" => y_next <= S16;
                when others => --do nothing
	    	end case;
            
        when S15=> y_next <= S13;
            
        when S16=> y_next <= rst;
            
        when S17=> y_next <= S13;
            
        when S18=> 
            if(tf = '1') then 
                if(opcode = "1100") then y_next <= S19;
                else y_next <= S24;
	    		end if;
                        
            else y_next <= S22;
	    	end if;
            
        when S19=> y_next <= S20;
            
        when S20=> y_next <= S21;
            
        when S21=> 
            if(T4_Z = '1') then y_next <= rst;
            
            else
                if(tf = '1') then
                    if(opcode = "1100") then y_next <= S19;
                    else y_next <= S22;
	    			end if;
                
                else y_next <= S22;
	    			end if;
	    	end if;
                
        when S22=> y_next <= S23;
                
        when S23=> 
            if(T4_Z = '1') then y_next <= rst;
                
            else
                if(tf = '1') then 
                    if(opcode = "1100") then y_next <= S19;
                    else y_next <= S22;
	    			end if;
                
                else y_next <= S22;
	    			end if;
	    		end if;
                
        when S24=> y_next <= S20;
                
        when others => 
	
	
	end case;

end if;

end process;
	

end architecture;  