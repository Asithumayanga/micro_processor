library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity Slow_Clk is
    generic (
        N : INTEGER := 26
    );
    Port (
        Clk_in  : in  STD_LOGIC;
        Clk_out : out STD_LOGIC
    );
end Slow_Clk;

architecture Behavioral of Slow_Clk is

    signal counter : unsigned(N downto 0) := (others => '0');  -- 27-bit binary counter

begin
    process(Clk_in)
    begin
        if rising_edge(Clk_in) then
            counter <= counter + 1;
        end if;
    end process;

    Clk_out <= counter(N);

end Behavioral;
