library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_Inc is
    Port ( Q : in STD_LOGIC_VECTOR (2 downto 0);
           D : out STD_LOGIC_VECTOR (2 downto 0));
end PC_Inc;

architecture Behavioral of PC_Inc is

begin
    D(0) <= NOT Q(0);
    D(1) <= Q(0) XOR Q(1);
    D(2) <= ((Q(2)) AND ((NOT Q(0)) OR (NOT Q(1)))) OR ((Q(0)) AND (Q(1)) AND (NOT Q(2)));

end Behavioral;
