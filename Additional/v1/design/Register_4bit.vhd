library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_4bit is
    Port ( 
        Clk     : in STD_LOGIC; 
        Res     : in STD_LOGIC;                    
        En      : in STD_LOGIC;                     
        D       : in STD_LOGIC_VECTOR(3 downto 0);  
        Q       : out STD_LOGIC_VECTOR(3 downto 0) 
    );
end Register_4bit;

architecture Behavioral of Register_4bit is
    signal Q_reg : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');  
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
          if Res = '0' then
            if En = '1' then
                Q_reg <= D;
            end if;
          else
            Q_reg <= "0000";
          end if;
        end if;
    end process;

    Q <= Q_reg;  
end Behavioral;
