library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2_to_1 is
        port(
            Sel : in std_logic;                                
            A : in std_logic_vector(2 downto 0);             
            B : in std_logic_vector(2 downto 0);             
            O : out std_logic_vector(2 downto 0)             
        );
end MUX_2_to_1;

architecture Behavioral of MUX_2_to_1 is

begin
    O <= A when Sel = '0' else B;
end behavioral;
