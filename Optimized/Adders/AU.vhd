library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           Sub : in  STD_LOGIC;
           S : out STD_LOGIC_VECTOR(3 downto 0);
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC);
end AU;

architecture Behavioral of AU is

    component RCA_4 is  --can use a faster adder without the RCA
        Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
               B : in  STD_LOGIC_VECTOR(3 downto 0);
               C_in : in  STD_LOGIC;
               S : out STD_LOGIC_VECTOR(3 downto 0);
               C_out : out STD_LOGIC);
    end component;

    signal Tmp_B : STD_LOGIC_VECTOR(3 downto 0);
    signal Sum : STD_LOGIC_VECTOR(3 downto 0);

begin

    RCA : adder_4bit
        port map (
            A => A,
            B => Tmp_B,
            C_in => Sub,
            S => Sum,
            C_out => Overflow
        );

    Tmp_B <= B XOR (Sub & Sub & Sub & Sub);
    S <= Sum;
    Zero  <= '1' when Sum = "0000" else '0';

end Behavioral;
