library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Comp is
end Test_Comp;

architecture Behavioral of Test_Comp is

    component Computer is
        Port ( Clk      : in  STD_LOGIC;
               Reset    : in  STD_LOGIC;
               SW       : in  STD_LOGIC;
               Seg7     : out STD_LOGIC_VECTOR(6 downto 0);
               data     : out STD_LOGIC_VECTOR(3 downto 0);
               Zero     : out STD_LOGIC;
               Overflow : out STD_LOGIC;
               Anode    : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal ClkIn    : STD_LOGIC := '0';
    signal ResetIn  : STD_LOGIC := '1';
    signal SW       : STD_LOGIC := '0';  -- switch starts OFF
    signal Overflow : STD_LOGIC;
    signal Zero     : STD_LOGIC;
    signal seg      : STD_LOGIC_VECTOR(6 downto 0);
    signal led      : STD_LOGIC_VECTOR(3 downto 0);
    signal Anode    : STD_LOGIC_VECTOR(3 downto 0);

begin

    uut : Computer
        port map (
            Clk      => ClkIn,
            Reset    => ResetIn,
            SW       => SW,
            Seg7     => seg,
            data     => led,
            Zero     => Zero,
            Overflow => Overflow,
            Anode    => Anode
        );

    -- Clock
    Clk_process : process
    begin
        ClkIn <= '0'; wait for 5ns;
        ClkIn <= '1'; wait for 5ns;
    end process;

    -- Stimulus
    stimulus : process
    begin
        ResetIn <= '1';
        SW      <= '0';        -- switch off
        wait for 50ns;

        ResetIn <= '0';        -- release reset
        wait for 100ns;        -- wait idle

        SW <= '1';             -- flip switch ON ? counter starts
        wait for 5000ns;       -- watch it count

        SW <= '0';             -- flip switch OFF ? counter freezes
        wait for 500ns;        -- confirm frozen

        SW <= '1';             -- flip back ON ? continues from where it stopped
        wait for 5000ns;

        wait;
    end process;

end Behavioral;