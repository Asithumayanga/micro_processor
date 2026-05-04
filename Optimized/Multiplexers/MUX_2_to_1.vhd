library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2_to_1 is
    Port ( A : in  STD_LOGIC_VECTOR(2 downto 0);
           B : in  STD_LOGIC_VECTOR(2 downto 0);
           S : in  STD_LOGIC;
           Y : out STD_LOGIC_VECTOR(2 downto 0));
end MUX_2_to_1;

architecture Behavioral of MUX_2_to_1 is

begin
    Y <= A when S = '0' else B;
end behavioral;
