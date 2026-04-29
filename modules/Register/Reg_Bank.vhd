library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_Bank is
    Port ( Reg_EN     : in  std_logic_vector(2 downto 0);
           Res        : in  STD_LOGIC;
           Clk        : in  STD_LOGIC;
           Data       : in  std_logic_vector(3 downto 0);
           Data_Buses : out buses_8_4);
end Register_Bank;

architecture Behavioral of Register_Bank is

    -- Local type definition (no package needed)
    type buses_8_4 is array (7 downto 0) of std_logic_vector(3 downto 0);

    -- Decoder component
    component Decoder_3_to_8 is
        Port ( I  : in  std_logic_vector(2 downto 0);
               EN : in  STD_LOGIC;
               Y  : out std_logic_vector(7 downto 0));
    end component;

    -- Reg component
    component Reg is
        Port ( D   : in  std_logic_vector(3 downto 0);
               Res : in  STD_LOGIC;
               En  : in  STD_LOGIC;
               Clk : in  STD_LOGIC;
               Q   : out std_logic_vector(3 downto 0));
    end component;

    signal Reg_Sel : std_logic_vector(7 downto 0);

begin

    -- 3-to-8 Decoder
    Decoder_3_to_8_0 : Decoder_3_to_8
        port map(
            I  => Reg_EN,
            EN => '1',
            Y  => Reg_Sel
        );

    -- R0 hardcoded to 0000 (read only)
    R0: Reg port map(D => "0000", Res => Res, En => '1',        Clk => Clk, Q => Data_Buses(0));

    -- R1 to R7
    R1: Reg port map(D => Data,   Res => Res, En => Reg_Sel(1), Clk => Clk, Q => Data_Buses(1));
    R2: Reg port map(D => Data,   Res => Res, En => Reg_Sel(2), Clk => Clk, Q => Data_Buses(2));
    R3: Reg port map(D => Data,   Res => Res, En => Reg_Sel(3), Clk => Clk, Q => Data_Buses(3));
    R4: Reg port map(D => Data,   Res => Res, En => Reg_Sel(4), Clk => Clk, Q => Data_Buses(4));
    R5: Reg port map(D => Data,   Res => Res, En => Reg_Sel(5), Clk => Clk, Q => Data_Buses(5));
    R6: Reg port map(D => Data,   Res => Res, En => Reg_Sel(6), Clk => Clk, Q => Data_Buses(6));
    R7: Reg port map(D => Data,   Res => Res, En => Reg_Sel(7), Clk => Clk, Q => Data_Buses(7));

end Behavioral;
