library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_ROM is
    port( ROM_address : in  STD_LOGIC_VECTOR(2 downto 0);
          I           : out STD_LOGIC_VECTOR(11 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is

    type ROM_Type is array (0 to 7) of STD_LOGIC_VECTOR(11 downto 0);
    constant Program : ROM_Type := (
        "101110000011",   -- MOVI R7, 3 
        "100010000001",    -- MOVI R1, 1 
        "010010000000",   -- NEG  R1
        "100100000011",   -- MOVI R2, 3
        "000100010000",    -- ADD  R2, R1 
        "001110100000",   -- ADD  R7, R2 
        "110100000110",   -- JZR  R2, 6 
        "110000000100"    -- JZR  R0, 4 
    );

begin
    I <= Program(to_integer(unsigned(ROM_address)));

end Behavioral;
