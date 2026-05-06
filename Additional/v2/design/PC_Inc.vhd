library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_Inc is
    Port ( Q : in  STD_LOGIC_VECTOR(4 downto 0);   -- 5-bit input  (32 slots)
           D : out STD_LOGIC_VECTOR(4 downto 0));   -- 5-bit output
end PC_Inc;

architecture Behavioral of PC_Inc is
begin
    D <= std_logic_vector(unsigned(Q) + 1);
end Behavioral;