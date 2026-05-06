library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_Bank is
PORT (
    RegEn : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);   -- 4-bit: selects 1 of 16 regs
    Data  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    Clk   : IN  STD_LOGIC;
    Res   : IN  STD_LOGIC;
    Reg0  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg1  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg2  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg3  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg4  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg5  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg6  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg7  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg8  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg9  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg10 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg11 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg12 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg13 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg14 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg15 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END Register_Bank;

ARCHITECTURE Behavioral OF Register_Bank IS

    COMPONENT Register_4bit
    PORT (
        Clk : IN  STD_LOGIC;
        Res : IN  STD_LOGIC;
        En  : IN  STD_LOGIC;
        D   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT Decoder_16
    PORT (
        Sel : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        O   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL Reg_Sel : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

    Dec : Decoder_16
        PORT MAP (Sel => RegEn, O => Reg_Sel);

    -- R0: hardwired to 0 (source of zero for NEG instruction)
    reg_0  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>'1',         D=>"0000", Q=>Reg0);
    reg_1  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(1),  D=>Data,   Q=>Reg1);
    reg_2  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(2),  D=>Data,   Q=>Reg2);
    reg_3  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(3),  D=>Data,   Q=>Reg3);
    reg_4  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(4),  D=>Data,   Q=>Reg4);
    reg_5  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(5),  D=>Data,   Q=>Reg5);
    reg_6  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(6),  D=>Data,   Q=>Reg6);
    reg_7  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(7),  D=>Data,   Q=>Reg7);
    reg_8  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(8),  D=>Data,   Q=>Reg8);
    reg_9  : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(9),  D=>Data,   Q=>Reg9);
    reg_10 : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(10), D=>Data,   Q=>Reg10);
    reg_11 : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(11), D=>Data,   Q=>Reg11);
    reg_12 : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(12), D=>Data,   Q=>Reg12);
    reg_13 : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(13), D=>Data,   Q=>Reg13);
    reg_14 : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(14), D=>Data,   Q=>Reg14);
    reg_15 : Register_4bit PORT MAP (Clk=>Clk, Res=>Res, En=>Reg_Sel(15), D=>Data,   Q=>Reg15);

END Behavioral;
