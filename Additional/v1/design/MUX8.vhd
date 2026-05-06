library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8 is
    Port (
        Sel  : in  STD_LOGIC_VECTOR(2 downto 0);                    
        I0   : in  STD_LOGIC_VECTOR(3 downto 0);   
        I1   : in  STD_LOGIC_VECTOR(3 downto 0);   
        I2   : in  STD_LOGIC_VECTOR(3 downto 0);  
        I3   : in  STD_LOGIC_VECTOR(3 downto 0);  
        I4   : in  STD_LOGIC_VECTOR(3 downto 0); 
        I5   : in  STD_LOGIC_VECTOR(3 downto 0);  
        I6   : in  STD_LOGIC_VECTOR(3 downto 0);  
        I7   : in  STD_LOGIC_VECTOR(3 downto 0);  
        O    : out STD_LOGIC_VECTOR(3 downto 0) 
    );
end MUX8;

architecture Behavioral of MUX8 is
begin
    process(Sel, I0, I1, I2, I3, I4, I5, I6, I7)
    begin
        case Sel is
            when "000" => O <= I0;  
            when "001" => O <= I1;  
            when "010" => O <= I2;  
            when "011" => O <= I3; 
            when "100" => O <= I4;  
            when "101" => O <= I5;  
            when "110" => O <= I6;  
            when "111" => O <= I7;  
            when others => O <= (others => '0'); 
        end case;
    end process;
end Behavioral;
