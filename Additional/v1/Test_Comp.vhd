library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Comp is
end Test_Comp;

architecture Behavioral of Test_Comp is

    component Computer is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Seg7   : out STD_LOGIC_VECTOR (6 downto 0);
           data :  out STD_LOGIC_VECTOR (3 downto 0);
           Zero :  out STD_LOGIC;
           Overflow :  out STD_LOGIC;
           Anode    : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    -- Internal signals
    signal ClkIn     : std_logic := '0';
    signal ResetIn   : std_logic := '0';
    signal Overflow  : std_logic;
    signal Zero      : std_logic;
    signal seg       : std_logic_vector(6 downto 0);
    signal led       : std_logic_vector(3 downto 0);
    signal Anode    : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Computer 
        port map (
            Clk      => ClkIn,
            Reset    => ResetIn,
            Seg7     => seg,
            data     => led,
            Zero     => Zero,
            Overflow => Overflow,
            Anode    => Anode
        );

    Reset_process : process 
    begin 
        ResetIn <= '1'; -- assert reset 
        wait for 20 ns;
        ResetIn <= '0'; -- release reset 
        wait; 
    end process;

    Clk_process : process
    begin
        while true loop
            ClkIn <= '0';
            wait for 5 ns;
            ClkIn <= '1';
            wait for 5 ns;
        end loop;
    end process;
   
end Behavioral;
