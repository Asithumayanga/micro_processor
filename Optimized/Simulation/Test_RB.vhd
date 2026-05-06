library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Test_RB is
end Test_RB;

architecture Behavioral of Test_RB is


    component Register_Bank
        Port (
            RegEn   : in  STD_LOGIC_VECTOR(2 downto 0);
            Data    : in  STD_LOGIC_VECTOR(3 downto 0);
            Clk     : in  STD_LOGIC;
            Reg0    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg1    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg2    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg3    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg4    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg5    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg6    : out STD_LOGIC_VECTOR(3 downto 0);
            Reg7    : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Test signals
    signal RegEn   : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Data    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Clk     : STD_LOGIC := '0';
    signal Reg0, Reg1, Reg2, Reg3, Reg4, Reg5, Reg6, Reg7 : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Register_Bank
        port map (
            RegEn => RegEn,
            Data  => Data,
            Clk   => Clk,
            Reg0  => Reg0,
            Reg1  => Reg1,
            Reg2  => Reg2,
            Reg3  => Reg3,
            Reg4  => Reg4,
            Reg5  => Reg5,
            Reg6  => Reg6,
            Reg7  => Reg7
        );

    -- Clock process
    clk_process : process
    begin
        Clk <= '0';
        wait for 5 ns;
        Clk <= '1';
        wait for 5 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Wait a bit before starting
        wait for 10 ns;

        -- Write 1010 to Reg1
        Data <= "1010";
        RegEn <= "001"; -- Select Reg1
        wait for 10 ns;

        -- Write 1100 to Reg2
        Data <= "1100";
        RegEn <= "010"; -- Select Reg2
        wait for 10 ns;

        -- Write 1111 to Reg7
        Data <= "1111";
        RegEn <= "111"; -- Select Reg7
        wait for 10 ns;

        -- Stop writing
        RegEn <= "000";
        Data <= "0000";
        wait for 10 ns;

        -- Done
        wait;
    end process;

end Behavioral;
