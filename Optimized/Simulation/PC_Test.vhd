library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_Test is
end PC_Test;

architecture Behavioral of PC_Test is

    -- Component declaration for Register_PC
    component Register_PC is
        Port ( 
            Clk  : in  STD_LOGIC;
            Res  : in  STD_LOGIC;
            D    : in  STD_LOGIC_VECTOR(2 downto 0);
            Q    : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Component declaration for PC_Inc
    component PC_Inc is
        Port (
            Q : in  STD_LOGIC_VECTOR(2 downto 0);
            D : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals
    signal Clk     : STD_LOGIC := '0';
    signal Res     : STD_LOGIC := '0';
    signal En      : STD_LOGIC := '1';
    signal Reg_Q   : STD_LOGIC_VECTOR(2 downto 0);
    signal Inc_D   : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instantiate Register_PC
    Reg : Register_PC
        port map (
            Clk => Clk,
            D   => Inc_D,
            Res => Res,
            Q   => Reg_Q
        );

    -- Instantiate PC_Inc
    PCI : PC_Inc
        port map (
            Q => Reg_Q,
            D => Inc_D
        );

    -- Clock process (10 ns period)
    Clock : process
    begin
        while true loop
            Clk <= '0';
            wait for 5 ns;
            Clk <= '1';
            wait for 5 ns;
        end loop;
    end process Clock;

    -- Stimulus process
    Stimulus : process
    begin
        -- Reset initially
        Res <= '1';
        wait for 20 ns;
        Res <= '0';

        -- Let PC run (value will increment through PC_Inc)
        wait for 100 ns;

        -- Stop simulation
        wait;
    end process Stimulus;

end Behavioral;
