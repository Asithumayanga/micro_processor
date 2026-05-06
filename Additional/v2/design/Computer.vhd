library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Computer is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           SW       : in  STD_LOGIC;           -- single switch
           Seg7     : out STD_LOGIC_VECTOR(6 downto 0);
           data     : out STD_LOGIC_VECTOR(3 downto 0);
           Zero     : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Anode    : out STD_LOGIC_VECTOR(3 downto 0));
end Computer;

architecture Behavioral of Computer is

    component Slow_Clk is
        generic ( N : INTEGER := 26 );
        Port ( Clk_in  : in  STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end component;

    component Display_Driver is
        Port ( Address       : in  STD_LOGIC_VECTOR(3 downto 0);
               driver_signal : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    component NanoProcessor is
        Port ( Reset    : in  STD_LOGIC;
               Clk      : in  STD_LOGIC;
               Overflow : out STD_LOGIC;
               Zero     : out STD_LOGIC;
               R7       : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal R7       : STD_LOGIC_VECTOR(3 downto 0);
    signal SC       : STD_LOGIC;
    signal Gated_SC : STD_LOGIC;  -- slow clock gated by switch

begin

    SlowClk : Slow_Clk
        generic map( N => 26 )  -- change to 2 for simulation
        port map(
            Clk_in  => Clk,
            Clk_out => SC
        );

    -- Gate slow clock with switch
    -- SW=0 ? processor frozen
    -- SW=1 ? processor runs
    Gated_SC <= SC AND SW;

    NP1 : NanoProcessor
        port map(
            Reset    => Reset,
            Clk      => Gated_SC,   -- gated clock
            Overflow => Overflow,
            Zero     => Zero,
            R7       => R7
        );

    Driver : Display_Driver
        port map(
            Address       => R7,
            driver_signal => Seg7
        );

    data  <= R7;
    Anode <= "1110";

end Behavioral;