library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU is
    Port ( A        : in  STD_LOGIC_VECTOR(3 downto 0);
           B        : in  STD_LOGIC_VECTOR(3 downto 0);
           Op       : in  STD_LOGIC_VECTOR(2 downto 0);  -- operation select
           S        : out STD_LOGIC_VECTOR(3 downto 0);
           Overflow : out STD_LOGIC;
           Zero     : out STD_LOGIC);
end AU;

-- Op encoding:
--  "000" = ADD  : S = A + B
--  "001" = SUB  : S = A - B  (NEG Ra uses A=R0=0, B=Ra => 0-Ra)
--  "010" = AND  : S = A AND B
--  "011" = OR   : S = A OR  B
--  "100" = NOT  : S = NOT A
--  others => S = "0000"

architecture Behavioral of AU is

    component adder_4bit is
        Port ( A     : in  STD_LOGIC_VECTOR(3 downto 0);
               B     : in  STD_LOGIC_VECTOR(3 downto 0);
               C_in  : in  STD_LOGIC;
               S     : out STD_LOGIC_VECTOR(3 downto 0);
               C_out : out STD_LOGIC);
    end component;

    signal Sub_Sel : STD_LOGIC;
    signal Tmp_B   : STD_LOGIC_VECTOR(3 downto 0);
    signal Add_Sum : STD_LOGIC_VECTOR(3 downto 0);
    signal Add_Co  : STD_LOGIC;
    signal Result  : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Drive subtraction control into the adder
    Sub_Sel <= '1' when Op = "001" else '0';
    Tmp_B   <= B XOR (Sub_Sel & Sub_Sel & Sub_Sel & Sub_Sel);

    RCA : adder_4bit
        port map(A => A, B => Tmp_B, C_in => Sub_Sel,
                 S => Add_Sum, C_out => Add_Co);

    -- Final result mux
    process(Op, Add_Sum, A, B)
    begin
        case Op is
            when "000"  => Result <= Add_Sum;      -- ADD
            when "001"  => Result <= Add_Sum;      -- SUB / NEG
            when "010"  => Result <= A AND B;      -- AND
            when "011"  => Result <= A OR  B;      -- OR
            when "100"  => Result <= NOT A;        -- NOT
            when others => Result <= (others => '0');
        end case;
    end process;

    -- Overflow only meaningful for arithmetic ops
    Overflow <= Add_Co when (Op = "000" or Op = "001") else '0';
    S        <= Result;
    Zero     <= '1' when Result = "0000" else '0';

end Behavioral;
