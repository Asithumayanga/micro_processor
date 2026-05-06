library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_AU is
end Test_AU ;

architecture Behavioral of Test_AU  is
  
    signal A, B : STD_LOGIC_VECTOR(3 downto 0);
    signal Sub : STD_LOGIC;
    signal S : STD_LOGIC_VECTOR(3 downto 0);
    signal Overflow : STD_LOGIC;
    signal Zero : STD_LOGIC;

    component AU is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Sub : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               Overflow : out STD_LOGIC;
               Zero : out STD_LOGIC);
    end component;

begin

UUT: AU
        port map (
            A => A,
            B => B,
            Sub => Sub,
            S => S,
            Overflow => Overflow,
            Zero => Zero
        );

   
    process
    begin
     
        A <= "0001"; 
        B <= "0010";  
        Sub <= '0';  
        wait for 10 ns;  
        
      
        A <= "0100";  
        B <= "0011";  
        Sub <= '1';   
        wait for 10 ns;  
        
       
        A <= "0011";  
        B <= "0011";  
        Sub <= '1';   
        wait for 10 ns;  

        wait;
    end process;
end Behavioral;
