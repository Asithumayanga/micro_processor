library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_8 is
    Port (
        Sel : in  STD_LOGIC_VECTOR(2 downto 0);
        O   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Decoder_8;

architecture Behavioral of Decoder_8 is
begin
    process(Sel)
    begin
        case Sel is
            when "000" => O <= "00000001";
            when "001" => O <= "00000010";
            when "010" => O <= "00000100";
            when "011" => O <= "00001000";
            when "100" => O <= "00010000";
            when "101" => O <= "00100000";
            when "110" => O <= "01000000";
            when "111" => O <= "10000000";
            when others => O <= (others => '0');
        end case;
    end process;
end Behavioral;
