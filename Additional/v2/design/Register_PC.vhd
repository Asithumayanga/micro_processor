library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_PC is
    Port (
        Clk : in  STD_LOGIC;
        Res : in  STD_LOGIC;                       -- active-high async reset
        D   : in  STD_LOGIC_VECTOR(4 downto 0);   -- 5-bit input  (32 slots)
        Q   : out STD_LOGIC_VECTOR(4 downto 0)    -- 5-bit output
    );
end Register_PC;

architecture Behavioral of Register_PC is
begin
    process(Clk, Res)
    begin
        if Res = '1' then
            Q <= (others => '0');       -- async reset to address 0
        elsif rising_edge(Clk) then
            Q <= D;
        end if;
    end process;
end Behavioral;
