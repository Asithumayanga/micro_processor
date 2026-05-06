library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Load_Selector is
    Port ( 
        A   : in STD_LOGIC_VECTOR (3 downto 0);
        B   : in STD_LOGIC_VECTOR (3 downto 0);
        Sel : in STD_LOGIC;
        O   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Load_Selector;

architecture Behavioral of Load_Selector is
begin
    process(A, B, Sel)  
    begin
        if Sel = '0' then
            O <= A;
        else
            O <= B;
        end if;
    end process;
end Behavioral;
