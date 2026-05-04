library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_PC is
    Port ( 
        Clk  : in  STD_LOGIC;                      -- Clock input
        Res  : in  STD_LOGIC;                      -- Reset input (active high)
        D    : in  STD_LOGIC_VECTOR(2 downto 0);   -- 3-bit data input
        Q    : out STD_LOGIC_VECTOR(2 downto 0)    -- 3-bit data output
    );
end Reg_PC;

architecture Behavioral of Reg_PC is
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Res = '1' then
                Q <= (others => '0');
            else
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
