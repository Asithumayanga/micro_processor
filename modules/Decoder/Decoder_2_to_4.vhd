library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_2_to_4 is
    Port ( I  : in  std_logic_vector(1 downto 0);
           EN : in  STD_LOGIC;
           Y  : out std_logic_vector(3 downto 0));
end Decoder_2_to_4;

architecture Behavioral of Decoder_2_to_4 is
begin
    Y(0) <= EN and (not I(1)) and (not I(0));
    Y(1) <= EN and (not I(1)) and      I(0);
    Y(2) <= EN and      I(1)  and (not I(0));
    Y(3) <= EN and      I(1)  and      I(0);
end Behavioral;
