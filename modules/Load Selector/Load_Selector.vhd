library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Load_Selector is
    Port ( LS : in  STD_LOGIC;
           IM : in  STD_LOGIC_VECTOR(3 downto 0);
           R  : in  STD_LOGIC_VECTOR(3 downto 0);
           O  : out STD_LOGIC_VECTOR(3 downto 0));
end Load_Selector;

architecture Behavioral of Load_Selector is
begin
    O <= IM when LS = '1' else R;
end Behavioral;
