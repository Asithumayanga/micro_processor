library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_3_to_8 is
    Port ( I  : in  STD_LOGIC_VECTOR(2 downto 0);
           EN : in  STD_LOGIC;
           Y  : out STD_LOGIC_VECTOR(7 downto 0));
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is

    component Decoder_2_to_4
        Port ( I  : in  STD_LOGIC_VECTOR(1 downto 0);
               EN : in  STD_LOGIC;
               Y  : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

begin

    D0 : Decoder_2_to_4
        port map(
            I  => I(1 downto 0),
            EN => EN and (not I(2)),
            Y  => Y(3 downto 0));

    D1 : Decoder_2_to_4
        port map(
            I  => I(1 downto 0),
            EN => EN and I(2),
            Y  => Y(7 downto 4));

end Behavioral;
