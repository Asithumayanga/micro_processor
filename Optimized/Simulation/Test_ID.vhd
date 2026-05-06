library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_ID is
end Test_ID;

architecture behavior of Test_ID is

    -- Component Declaration for the Unit Under Test (UUT)
    component Instruction_Decoder
        Port (
            Instruction   : in  STD_LOGIC_VECTOR(11 downto 0);
            JumpCheck     : in  STD_LOGIC_VECTOR(3 downto 0);
            RegEn         : out STD_LOGIC_VECTOR(2 downto 0);
            Sel_A         : out STD_LOGIC_VECTOR(2 downto 0);
            Sel_B         : out STD_LOGIC_VECTOR(2 downto 0);
            LoadSel       : out STD_LOGIC;
            ImmVal        : out STD_LOGIC_VECTOR(3 downto 0);
            Sub           : out STD_LOGIC;
            JumpFlag      : out STD_LOGIC;
            JumpAddress   : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal Instruction   : STD_LOGIC_VECTOR(11 downto 0);
    signal JumpCheck     : STD_LOGIC_VECTOR(3 downto 0);
    signal RegEn         : STD_LOGIC_VECTOR(2 downto 0);
    signal Sel_A         : STD_LOGIC_VECTOR(2 downto 0);
    signal Sel_B         : STD_LOGIC_VECTOR(2 downto 0);
    signal LoadSel       : STD_LOGIC;
    signal ImmVal        : STD_LOGIC_VECTOR(3 downto 0);
    signal Sub           : STD_LOGIC;
    signal JumpFlag      : STD_LOGIC;
    signal JumpAddress   : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Instruction_Decoder
        Port map (
            Instruction   => Instruction,
            JumpCheck     => JumpCheck,
            RegEn         => RegEn,
            Sel_A         => Sel_A,
            Sel_B         => Sel_B,
            LoadSel       => LoadSel,
            ImmVal        => ImmVal,
            Sub           => Sub,
            JumpFlag      => JumpFlag,
            JumpAddress   => JumpAddress
        );

    -- Stimulus process
    stim_proc: process
    begin
        JumpCheck <= "1111";
        
        -- MOVI R7, 3 
        Instruction <= "101110000011";
        Wait for 10 ns;
        
        -- ADD  R2, R1 
        Instruction <= "000100010000";
        Wait for 10 ns;
        
         -- JZR  R2, 6 
         Instruction <= "110100000110";
         Wait for 10 ns;
         
         -- JZR  R2, 6 
         JumpCheck <= "0000";
         Instruction <= "110100000110";
         Wait for 10 ns;
        
        
        
     
        wait;
    end process;

end behavior;
