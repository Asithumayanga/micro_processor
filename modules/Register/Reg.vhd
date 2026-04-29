library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
    Port ( D   : in  std_logic_vector(3 downto 0);
           Res : in  STD_LOGIC;
           En  : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Q   : out std_logic_vector(3 downto 0));
end Reg;

architecture Behavioral of Reg is

    component D_FF is
        Port ( D   : in  STD_LOGIC;
               Res : in  STD_LOGIC;
               Clk : in  STD_LOGIC;
               En  : in  STD_LOGIC;
               Q   : out STD_LOGIC);
    end component;

begin

    FF0: D_FF port map(D => D(0), Res => Res, Clk => Clk, En => En, Q => Q(0));
    FF1: D_FF port map(D => D(1), Res => Res, Clk => Clk, En => En, Q => Q(1));
    FF2: D_FF port map(D => D(2), Res => Res, Clk => Clk, En => En, Q => Q(2));
    FF3: D_FF port map(D => D(3), Res => Res, Clk => Clk, En => En, Q => Q(3));

end Behavioral;
