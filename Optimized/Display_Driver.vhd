library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Driver is
    Port ( Address : in STD_LOGIC_VECTOR (3 downto 0);
           driver_signal : out STD_LOGIC_VECTOR (6 downto 0)
           );
end Display_Driver;

architecture Behavioral of Display_Driver is

Component MUX8 is
    Port (
        Sel   : in  STD_LOGIC_VECTOR(2 downto 0);                    
        I0    : in  STD_LOGIC_VECTOR(3 downto 0);   
        I1    : in  STD_LOGIC_VECTOR(3 downto 0);   
        I2    : in  STD_LOGIC_VECTOR(3 downto 0);  
        I3    : in  STD_LOGIC_VECTOR(3 downto 0);  
        I4    : in  STD_LOGIC_VECTOR(3 downto 0); 
        I5    : in  STD_LOGIC_VECTOR(3 downto 0);  
        I6    : in  STD_LOGIC_VECTOR(3 downto 0);  
        I7    : in  STD_LOGIC_VECTOR(3 downto 0);  
        O     : out STD_LOGIC_VECTOR(3 downto 0) 
    );
end Component;
    
type rom_type is array (0 to 15) of std_logic_vector(6 downto 0);
    
    signal sevenSegment_ROM : rom_type := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- B
        "1000110", -- C
        "0100001", -- D
        "0000110", -- E
        "0001110"  -- F
);            
begin

driver_signal <= sevenSegment_ROM(to_integer(unsigned(Address)));

end Behavioral;
