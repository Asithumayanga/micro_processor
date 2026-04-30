library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_8_to_1 is
    Port ( S  : in  STD_LOGIC_VECTOR(2 downto 0);
           D  : in  STD_LOGIC_VECTOR(7 downto 0);
           EN : in  STD_LOGIC;
           Y  : out STD_LOGIC);
end Mux_8_to_1;

architecture Behavioral of Mux_8_to_1 is
    signal Y_int : STD_LOGIC;
begin
    with S select
        Y_int <= D(0) when "000",
                 D(1) when "001",
                 D(2) when "010",
                 D(3) when "011",
                 D(4) when "100",
                 D(5) when "101",
                 D(6) when "110",
                 D(7) when "111",
                 '0'  when others;

    Y <= Y_int and EN;
end Behavioral;
