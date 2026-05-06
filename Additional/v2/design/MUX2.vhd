library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2 is
    Port (
        Sel : in  STD_LOGIC;
        A   : in  STD_LOGIC_VECTOR(4 downto 0);   -- PC+1  (next sequential)
        B   : in  STD_LOGIC_VECTOR(4 downto 0);   -- jump address
        O   : out STD_LOGIC_VECTOR(4 downto 0)
    );
end MUX2;

architecture Behavioral of MUX2 is
begin
    O <= A when Sel = '0' else B;
end Behavioral;