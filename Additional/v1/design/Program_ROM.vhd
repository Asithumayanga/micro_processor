library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_ROM is
    port( ROM_address : in  STD_LOGIC_VECTOR(4 downto 0);
          I           : out STD_LOGIC_VECTOR(15 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is
    type ROM_Type is array(0 to 31) of STD_LOGIC_VECTOR(15 downto 0);
    constant Program : ROM_Type := (
        0  => "0100111000000011",  -- MOVI R7, 3
        1  => "0100001000001111",  -- MOVI R1, 15
        2  => "0010001000000000",  -- NEG  R1
        3  => "0100010000000101",  -- MOVI R2, 5
        4  => "1000111000100000",  -- AND  R7, R1
        5  => "1010111001000000",  -- OR   R7, R2
        6  => "0000111001000000",  -- ADD  R7, R2
        7  => "1100010000000000",  -- NOT  R2
        8  => "1000111001000000",  -- AND  R7, R2
        9  => "0110000000000000",  -- JZR  R0, 0
        others => "0100000000000000"  -- NOP
    );
begin
    I <= Program(to_integer(unsigned(ROM_address)));
end Behavioral;