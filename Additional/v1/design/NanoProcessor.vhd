library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NanoProcessor is
    Port ( Reset    : in  STD_LOGIC;
           Clk      : in  STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero     : out STD_LOGIC;
           R7       : out STD_LOGIC_VECTOR(3 downto 0)
    );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

    -- ----------------------------------------------------------------
    -- Component declarations
    -- ----------------------------------------------------------------
    component Instruction_Decoder is
        Port (
            Instruction : in  STD_LOGIC_VECTOR(15 downto 0);
            JumpCheck   : in  STD_LOGIC_VECTOR(3 downto 0);
            RegEn       : out STD_LOGIC_VECTOR(3 downto 0);
            Sel_A       : out STD_LOGIC_VECTOR(3 downto 0);
            Sel_B       : out STD_LOGIC_VECTOR(3 downto 0);
            LoadSel     : out STD_LOGIC;
            ImmVal      : out STD_LOGIC_VECTOR(3 downto 0);
            Op          : out STD_LOGIC_VECTOR(2 downto 0);
            JumpFlag    : out STD_LOGIC;
            JumpAddress : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component MUX16 is
        Port (
            Sel : in  STD_LOGIC_VECTOR(3 downto 0);
            I0  : in  STD_LOGIC_VECTOR(3 downto 0);
            I1  : in  STD_LOGIC_VECTOR(3 downto 0);
            I2  : in  STD_LOGIC_VECTOR(3 downto 0);
            I3  : in  STD_LOGIC_VECTOR(3 downto 0);
            I4  : in  STD_LOGIC_VECTOR(3 downto 0);
            I5  : in  STD_LOGIC_VECTOR(3 downto 0);
            I6  : in  STD_LOGIC_VECTOR(3 downto 0);
            I7  : in  STD_LOGIC_VECTOR(3 downto 0);
            I8  : in  STD_LOGIC_VECTOR(3 downto 0);
            I9  : in  STD_LOGIC_VECTOR(3 downto 0);
            I10 : in  STD_LOGIC_VECTOR(3 downto 0);
            I11 : in  STD_LOGIC_VECTOR(3 downto 0);
            I12 : in  STD_LOGIC_VECTOR(3 downto 0);
            I13 : in  STD_LOGIC_VECTOR(3 downto 0);
            I14 : in  STD_LOGIC_VECTOR(3 downto 0);
            I15 : in  STD_LOGIC_VECTOR(3 downto 0);
            O   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component MUX2 is
        Port (
            Sel : in  STD_LOGIC;
            A   : in  STD_LOGIC_VECTOR(4 downto 0);
            B   : in  STD_LOGIC_VECTOR(4 downto 0);
            O   : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component Load_Selector is
        Port (
            A   : in  STD_LOGIC_VECTOR(3 downto 0);
            B   : in  STD_LOGIC_VECTOR(3 downto 0);
            Sel : in  STD_LOGIC;
            O   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component PC_Inc is
        Port (
            Q : in  STD_LOGIC_VECTOR(4 downto 0);
            D : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component Program_ROM is
        Port (
            ROM_address : in  STD_LOGIC_VECTOR(4 downto 0);
            I           : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component Register_PC is
        Port (
            Clk : in  STD_LOGIC;
            Res : in  STD_LOGIC;
            D   : in  STD_LOGIC_VECTOR(4 downto 0);
            Q   : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component AU is
        Port (
            A        : in  STD_LOGIC_VECTOR(3 downto 0);
            B        : in  STD_LOGIC_VECTOR(3 downto 0);
            Op       : in  STD_LOGIC_VECTOR(2 downto 0);
            S        : out STD_LOGIC_VECTOR(3 downto 0);
            Overflow : out STD_LOGIC;
            Zero     : out STD_LOGIC
        );
    end component;

    component Register_Bank is
        Port (
            RegEn : in  STD_LOGIC_VECTOR(3 downto 0);
            Data  : in  STD_LOGIC_VECTOR(3 downto 0);
            Clk   : in  STD_LOGIC;
            Res   : in  STD_LOGIC;
            Reg0  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg1  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg2  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg3  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg4  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg5  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg6  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg7  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg8  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg9  : out STD_LOGIC_VECTOR(3 downto 0);
            Reg10 : out STD_LOGIC_VECTOR(3 downto 0);
            Reg11 : out STD_LOGIC_VECTOR(3 downto 0);
            Reg12 : out STD_LOGIC_VECTOR(3 downto 0);
            Reg13 : out STD_LOGIC_VECTOR(3 downto 0);
            Reg14 : out STD_LOGIC_VECTOR(3 downto 0);
            Reg15 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- ----------------------------------------------------------------
    -- Internal signals
    -- ----------------------------------------------------------------
    signal Current_Address  : STD_LOGIC_VECTOR(4 downto 0);
    signal Next_Address     : STD_LOGIC_VECTOR(4 downto 0);
    signal Selected_Address : STD_LOGIC_VECTOR(4 downto 0);
    signal Jump_Address     : STD_LOGIC_VECTOR(4 downto 0);
    signal Jump_Flag        : STD_LOGIC;
    signal Instruction      : STD_LOGIC_VECTOR(15 downto 0);

    signal t0,t1,t2,t3,t4,t5,t6,t7     : STD_LOGIC_VECTOR(3 downto 0);
    signal t8,t9,t10,t11,t12,t13,t14,t15 : STD_LOGIC_VECTOR(3 downto 0);

    signal Load_Selection   : STD_LOGIC;
    signal Immediate_Value  : STD_LOGIC_VECTOR(3 downto 0);
    signal ASelect          : STD_LOGIC_VECTOR(3 downto 0);
    signal BSelect          : STD_LOGIC_VECTOR(3 downto 0);
    signal AData            : STD_LOGIC_VECTOR(3 downto 0);
    signal BData            : STD_LOGIC_VECTOR(3 downto 0);
    signal Operation_Result : STD_LOGIC_VECTOR(3 downto 0);
    signal Op_Sel           : STD_LOGIC_VECTOR(2 downto 0);
    signal Register_Enable  : STD_LOGIC_VECTOR(3 downto 0);
    signal Selected_Load    : STD_LOGIC_VECTOR(3 downto 0);

begin

    Program_Counter : Register_PC
        Port Map (Clk => Clk, Res => Reset,
                  D   => Selected_Address,
                  Q   => Current_Address);

    Incrementer : PC_Inc
        Port Map (Q => Current_Address, D => Next_Address);

    Next_Address_Selector : MUX2
        Port Map (Sel => Jump_Flag,
                  A   => Next_Address,
                  B   => Jump_Address,
                  O   => Selected_Address);

    ProgramROM : Program_ROM
        Port Map (ROM_address => Current_Address, I => Instruction);

    InstructionDecoder : Instruction_Decoder
        Port Map (
            Instruction => Instruction,
            JumpCheck   => AData,
            RegEn       => Register_Enable,
            Sel_A       => ASelect,
            Sel_B       => BSelect,
            LoadSel     => Load_Selection,
            ImmVal      => Immediate_Value,
            Op          => Op_Sel,
            JumpFlag    => Jump_Flag,
            JumpAddress => Jump_Address
        );

    RegisterBank : Register_Bank
        Port Map (
            RegEn => Register_Enable,
            Data  => Selected_Load,
            Clk   => Clk,
            Res   => Reset,
            Reg0  => t0,  Reg1  => t1,  Reg2  => t2,  Reg3  => t3,
            Reg4  => t4,  Reg5  => t5,  Reg6  => t6,  Reg7  => t7,
            Reg8  => t8,  Reg9  => t9,  Reg10 => t10, Reg11 => t11,
            Reg12 => t12, Reg13 => t13, Reg14 => t14, Reg15 => t15
        );

    Selector_A : MUX16
        Port Map (
            Sel => ASelect,
            I0  => t0,  I1  => t1,  I2  => t2,  I3  => t3,
            I4  => t4,  I5  => t5,  I6  => t6,  I7  => t7,
            I8  => t8,  I9  => t9,  I10 => t10, I11 => t11,
            I12 => t12, I13 => t13, I14 => t14, I15 => t15,
            O   => AData
        );

    Selector_B : MUX16
        Port Map (
            Sel => BSelect,
            I0  => t0,  I1  => t1,  I2  => t2,  I3  => t3,
            I4  => t4,  I5  => t5,  I6  => t6,  I7  => t7,
            I8  => t8,  I9  => t9,  I10 => t10, I11 => t11,
            I12 => t12, I13 => t13, I14 => t14, I15 => t15,
            O   => BData
        );

    Arithmetic_Unit : AU
        Port Map (
            A        => AData,
            B        => BData,
            Op       => Op_Sel,
            S        => Operation_Result,
            Overflow => Overflow,
            Zero     => Zero
        );

    LoadSelector : Load_Selector
        Port Map (
            A   => Operation_Result,
            B   => Immediate_Value,
            Sel => Load_Selection,
            O   => Selected_Load
        );

    R7 <= t7;   -- R7 remains the display output register

end Behavioral;
