library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_16 is
    Port (
        Sel : in  STD_LOGIC_VECTOR(3 downto 0);
        O   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end Decoder_16;

architecture Behavioral of Decoder_16 is
begin
    process(Sel)
    begin
        O <= (others => '0');
        case Sel is
            when "0000" => O <= "0000000000000001";
            when "0001" => O <= "0000000000000010";
            when "0010" => O <= "0000000000000100";
            when "0011" => O <= "0000000000001000";
            when "0100" => O <= "0000000000010000";
            when "0101" => O <= "0000000000100000";
            when "0110" => O <= "0000000001000000";
            when "0111" => O <= "0000000010000000";
            when "1000" => O <= "0000000100000000";
            when "1001" => O <= "0000001000000000";
            when "1010" => O <= "0000010000000000";
            when "1011" => O <= "0000100000000000";
            when "1100" => O <= "0001000000000000";
            when "1101" => O <= "0010000000000000";
            when "1110" => O <= "0100000000000000";
            when "1111" => O <= "1000000000000000";
            when others => O <= (others => '0');
        end case;
    end process;
end Behavioral;
