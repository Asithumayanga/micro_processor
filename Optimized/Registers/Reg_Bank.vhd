library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_Bank is
PORT (
    RegEn   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    Data    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    Clk     : IN  STD_LOGIC;
    Res     : IN  STD_LOGIC;
    Reg0    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg1    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg2    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg3    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg4    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg5    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg6    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg7    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END Reg_Bank;

ARCHITECTURE Behavioral OF Reg_Bank IS

    COMPONENT Register_4bit
    PORT (
        Clk   : IN  STD_LOGIC;
        Res   : IN STD_LOGIC;
        En    : IN  STD_LOGIC;
        D     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT Decoder_8
    PORT (
        Sel : in  STD_LOGIC_VECTOR(2 downto 0);
        O   : out STD_LOGIC_VECTOR(7 downto 0)
    );
    END COMPONENT;

    SIGNAL Reg_Sel : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    Decoder_3_to_8 : Decoder_8
    PORT MAP (
        Sel => RegEn, 
        O   => Reg_Sel
    );

    reg_0 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => '1',
            D     => "0000",
            Q     => Reg0
        );

    reg_1 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(1),
            D     => Data,
            Q     => Reg1
        );

    reg_2 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(2),
            D     => Data,
            Q     => Reg2
        );

    reg_3 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(3),
            D     => Data,
            Q     => Reg3
        );

    reg_4 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(4),
            D     => Data,
            Q     => Reg4
        );

    reg_5 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(5),
            D     => Data,
            Q     => Reg5
        );

    reg_6 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(6),
            D     => Data,
            Q     => Reg6
        );

    reg_7 : Register_4bit
        PORT MAP (
            Clk   => Clk,
            Res   => Res,
            En    => Reg_Sel(7),
            D     => Data,
            Q     => Reg7
        );

END Behavioral;
