library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity adder_4bit is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           C_in : in  STD_LOGIC;
           S : out STD_LOGIC_VECTOR(3 downto 0);
           C_out : out STD_LOGIC);
end adder_4bit;

architecture Structural of adder_4bit is

    signal P  : STD_LOGIC_VECTOR(3 downto 0);
    signal CO : STD_LOGIC_VECTOR(3 downto 0);

begin

    P(0) <= A(0) XOR B(0);
    P(1) <= A(1) XOR B(1);
    P(2) <= A(2) XOR B(2);
    P(3) <= A(3) XOR B(3);

    CARRY4_inst : CARRY4
        port map (
            CI => C_in,
            CYINIT => '0',
            DI => A,
            S => P,
            O => S,
            CO => CO
        );

    C_out <= CO(3);

end Structural;