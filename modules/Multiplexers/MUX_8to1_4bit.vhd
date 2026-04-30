library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_8to1_4bit is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           C : in  STD_LOGIC_VECTOR(3 downto 0);
           D : in  STD_LOGIC_VECTOR(3 downto 0);
           E : in  STD_LOGIC_VECTOR(3 downto 0);
           F : in  STD_LOGIC_VECTOR(3 downto 0);
           G : in  STD_LOGIC_VECTOR(3 downto 0);
           H : in  STD_LOGIC_VECTOR(3 downto 0);
           S : in  STD_LOGIC_VECTOR(2 downto 0);
           Y : out STD_LOGIC_VECTOR(3 downto 0));
end MUX_8to1_4bit;

architecture Behavioral of MUX_8to1_4bit is

    component Mux_8_to_1 is
        Port ( I : in  STD_LOGIC_VECTOR(7 downto 0);
               S : in  STD_LOGIC_VECTOR(2 downto 0);
               Y : out STD_LOGIC);
    end component;

begin

    -- One 8-to-1 mux per bit
    Mux_bit0 : Mux_8_to_1 port map(
        I => (A(0) & B(0) & C(0) & D(0) & E(0) & F(0) & G(0) & H(0)),
        S => S,
        Y => Y(0));

    Mux_bit1 : Mux_8_to_1 port map(
        I => (A(1) & B(1) & C(1) & D(1) & E(1) & F(1) & G(1) & H(1)),
        S => S,
        Y => Y(1));

    Mux_bit2 : Mux_8_to_1 port map(
        I => (A(2) & B(2) & C(2) & D(2) & E(2) & F(2) & G(2) & H(2)),
        S => S,
        Y => Y(2));

    Mux_bit3 : Mux_8_to_1 port map(
        I => (A(3) & B(3) & C(3) & D(3) & E(3) & F(3) & G(3) & H(3)),
        S => S,
        Y => Y(3));

end Behavioral;
