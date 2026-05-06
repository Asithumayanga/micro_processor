library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Computer is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Seg7   : out STD_LOGIC_VECTOR (6 downto 0);
           data :  out STD_LOGIC_VECTOR (3 downto 0);
           Zero :  out STD_LOGIC;
           Overflow :  out STD_LOGIC;
           Anode: out STD_LOGIC_VECTOR (3 downto 0));
end Computer;

architecture Behavioral of Computer is

Component Slow_Clk is
    generic (
        N : INTEGER := 26
    );
    Port (
        Clk_in  : in  STD_LOGIC;
        Clk_out : out STD_LOGIC
    );
end Component;

Component Display_Driver is
    Port ( Address : in STD_LOGIC_VECTOR (3 downto 0);
           driver_signal : out STD_LOGIC_VECTOR (6 downto 0)
     );
end Component;


Component NanoProcessor is
         Port ( Reset    : in STD_LOGIC;
                Clk      : in STD_LOGIC;
                Overflow : out std_logic;
                Zero     : out std_logic; 
               
                R7 : out STD_LOGIC_VECTOR (3 downto 0)
                );
end Component;

Signal  R7 : STD_LOGIC_VECTOR (3 downto 0);
Signal  SC : STD_LOGIC;


begin

 SlowClk : Slow_Clk
        generic map( N => 26 )
        port map(
            Clk_in  => Clk,
            Clk_out => SC
        );
  

NP1 :  NanoProcessor 
    Port Map(
          Reset    => Reset,
          Clk      => SC,
          Overflow => Overflow,
          Zero     => Zero,
          R7       => R7
      );
      
Driver :  Display_Driver 
          Port Map(
                Address  => R7,
                driver_signal  => Seg7
            );
            
 data <= R7;
 Anode <= "1110";
end Behavioral;
