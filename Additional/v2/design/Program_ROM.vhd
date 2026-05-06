library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_ROM is
    port( ROM_address : in  STD_LOGIC_VECTOR(4 downto 0);  -- 5-bit for 32 slots
          I           : out STD_LOGIC_VECTOR(15 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is
    type ROM_Type is array (0 to 31) of STD_LOGIC_VECTOR(15 downto 0);
    constant Program : ROM_Type := (
        0  => "0100111000000001",  -- MOVI R7, 1
        1  => "0100001000000001",  -- MOVI R1, 1
        2  => "0000111000100000",  -- ADD  R7, R1
        3  => "0110000000000010",  -- JZR  R0, 2
        others => "0100000000000000"  -- NOP
    );
begin
    I <= Program(to_integer(unsigned(ROM_address)));
end Behavioral;