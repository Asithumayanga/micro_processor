library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
    Port ( D : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           En  : in  STD_LOGIC;
           Q : out STD_LOGIC); -- Q_bar is not instantiated because,
end D_FF;                      -- it is unused in the register bank

architecture Behavioral of D_FF is

begin
    process (Clk) begin
        if (rising_edge(Clk)) then
            if Res = '1' then         --Clear output when reset is high
                Q <= '0';
            elsif En = '1' then                      --Else output is same as input
                Q <= D;
            end if;
        end if;
    end process;

end Behavioral;
