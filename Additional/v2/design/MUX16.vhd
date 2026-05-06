library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX16 is
    Port (
        Sel : in  STD_LOGIC_VECTOR(3 downto 0);
        I0  : in  STD_LOGIC_VECTOR(3 downto 0);
        I1  : in  STD_LOGIC_VECTOR(3 downto 0);
        I2  : in  STD_LOGIC_VECTOR(3 downto 0);
        I3  : in  STD_LOGIC_VECTOR(3 downto 0);
        I4  : in  STD_LOGIC_VECTOR(3 downto 0);
        I5  : in  STD_LOGIC_VECTOR(3 downto 0);
        I6  : in  STD_LOGIC_VECTOR(3 downto 0);
        I7  : in  STD_LOGIC_VECTOR(3 downto 0);
        I8  : in  STD_LOGIC_VECTOR(3 downto 0);
        I9  : in  STD_LOGIC_VECTOR(3 downto 0);
        I10 : in  STD_LOGIC_VECTOR(3 downto 0);
        I11 : in  STD_LOGIC_VECTOR(3 downto 0);
        I12 : in  STD_LOGIC_VECTOR(3 downto 0);
        I13 : in  STD_LOGIC_VECTOR(3 downto 0);
        I14 : in  STD_LOGIC_VECTOR(3 downto 0);
        I15 : in  STD_LOGIC_VECTOR(3 downto 0);
        O   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end MUX16;

architecture Behavioral of MUX16 is
begin
    process(Sel, I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15)
    begin
        case Sel is
            when "0000" => O <= I0;
            when "0001" => O <= I1;
            when "0010" => O <= I2;
            when "0011" => O <= I3;
            when "0100" => O <= I4;
            when "0101" => O <= I5;
            when "0110" => O <= I6;
            when "0111" => O <= I7;
            when "1000" => O <= I8;
            when "1001" => O <= I9;
            when "1010" => O <= I10;
            when "1011" => O <= I11;
            when "1100" => O <= I12;
            when "1101" => O <= I13;
            when "1110" => O <= I14;
            when "1111" => O <= I15;
            when others => O <= (others => '0');
        end case;
    end process;
end Behavioral;
