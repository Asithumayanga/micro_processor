library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NanoProcessor is
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Overflow : out std_logic;
           Zero : out std_logic; 
           R7 : out STD_LOGIC_VECTOR (3 downto 0)
           );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

Component Instruction_Decoder is
    Port (
        Instruction : in STD_LOGIC_VECTOR(11 downto 0);
        JumpCheck : in STD_LOGIC_VECTOR(3 downto 0);
        RegEn : out STD_LOGIC_VECTOR(2 downto 0);
        Sel_A : out STD_LOGIC_VECTOR(2 downto 0);
        Sel_B : out STD_LOGIC_VECTOR(2 downto 0);
        LoadSel : out STD_LOGIC;
        ImmVal : out STD_LOGIC_VECTOR(3 downto 0);
        Sub : out STD_LOGIC;
        JumpFlag : out STD_LOGIC;
        JumpAddress : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Component;

Component MUX_8_to_1 is
    Port (
        Sel : in STD_LOGIC_VECTOR(2 downto 0);                    
        I0 : in STD_LOGIC_VECTOR(3 downto 0);   
        I1 : in STD_LOGIC_VECTOR(3 downto 0);   
        I2 : in STD_LOGIC_VECTOR(3 downto 0);  
        I3 : in STD_LOGIC_VECTOR(3 downto 0);  
        I4 : in STD_LOGIC_VECTOR(3 downto 0); 
        I5 : in STD_LOGIC_VECTOR(3 downto 0);  
        I6 : in STD_LOGIC_VECTOR(3 downto 0);  
        I7 : in STD_LOGIC_VECTOR(3 downto 0);  
        O : out STD_LOGIC_VECTOR(3 downto 0) 
    );
end Component;
    
Component MUX_2_to_1 is
        port(
            Sel : in std_logic;                                
            A : in std_logic_vector(2 downto 0);             
            B : in std_logic_vector(2 downto 0);             
            O : out std_logic_vector(2 downto 0)             
        );
 end Component;
 
Component MUX_2_to_1_4bit is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Sel : in STD_LOGIC;
               O : out STD_LOGIC_VECTOR (3 downto 0));
 end Component;

Component PC_Inc is
    Port ( Q : in STD_LOGIC_VECTOR (2 downto 0);
           D : out STD_LOGIC_VECTOR (2 downto 0));
end Component;

Component Program_ROM is
    port(ROM_address : in STD_LOGIC_VECTOR (2 downto 0);
          I : out STD_LOGIC_VECTOR (11 downto 0)
         ); 
end Component;

Component Reg_PC is
   Port ( 
            Clk : in STD_LOGIC;                      
            Res : in STD_LOGIC;                     
            D : in STD_LOGIC_VECTOR(2 downto 0);   
            Q : out STD_LOGIC_VECTOR(2 downto 0)   
         );
end Component;

Component AU is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Sub : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC);
end Component;

Component Reg_Bank is
PORT (
    RegEn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    Data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    Clk : IN STD_LOGIC;
    Res : IN STD_LOGIC;
    Reg0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg5 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg6 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Reg7 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END Component;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

    signal Next_Address : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal Current_Address : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal Selected_Address : STD_LOGIC_VECTOR(2 DOWNTO 0); 
    signal Jump_Address : STD_LOGIC_VECTOR(2 DOWNTO 0); 
    signal Jump_Flag : std_logic; 
    signal Instruction : STD_LOGIC_VECTOR(11 DOWNTO 0); 
    
    signal t0, t1, t2, t3, t4, t5, t6, t7 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    signal Load_Selection : std_logic; 
    signal Immediate_Value : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal ASelect : STD_LOGIC_VECTOR(2 DOWNTO 0); 
    signal BSelect : STD_LOGIC_VECTOR(2 DOWNTO 0); 
    signal AData : STD_LOGIC_VECTOR(3 DOWNTO 0); 
    signal BData : STD_LOGIC_VECTOR(3 DOWNTO 0); 
    signal Operation_Result : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Sub_Sel : std_logic; 
    signal Register_Enable : STD_LOGIC_VECTOR(2 DOWNTO 0); 
    signal Selected_Load : STD_LOGIC_VECTOR(3 DOWNTO 0); 
    
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
    
    
begin

Program_Counter : Reg_PC
Port Map ( 
    Clk => Clk,                    
    Res => Reset,                                          
      D => Selected_Address, 
      Q => Current_Address   
);

Incrementer : PC_Inc
 Port Map ( 
    Q => Current_Address,
    D => Next_Address
);

Next_Address_Selector : MUX_2_to_1
Port Map ( 
    Sel => Jump_Flag,                       
      A => Next_Address,          
      B => Jump_Address,     
      O => Selected_Address   
);

InstructionDecoder : Instruction_Decoder
    Port Map (
        Instruction => Instruction,
        JumpCheck => AData,
        RegEn => Register_Enable,
        Sel_A => ASelect,
        Sel_B => BSelect,
        LoadSel => Load_Selection,
        ImmVal => Immediate_Value,
        Sub => Sub_Sel,
        JumpFlag => Jump_Flag,
        JumpAddress => Jump_Address
    );
    
LoadSelector : MUX_2_to_1_4bit
     Port Map ( 
       A => Operation_Result,
       B => Immediate_Value,
       Sel => Load_Selection,
       O => Selected_Load
     );
                   
                   
RegisterBank : Reg_Bank 
    Port Map (
        RegEn => Register_Enable,
        Data => Selected_Load,
        Clk => Clk,
        Res => Reset,
        Reg0 => t0,
        Reg1 => t1,
        Reg2 => t2,
        Reg3 => t3,
        Reg4 => t4,
        Reg5 => t5,
        Reg6 => t6,
        Reg7 => t7
    );
    
 Selector_A : MUX_8_to_1
      Port Map (
        Sel => ASelect,                   
        I0 => t0,
        I1 => t1,  
        I2 => t2,
        I3 => t3,
        I4 => t4,
        I5 => t5, 
        I6 => t6,
        I7 => t7,
        O => AData
      );

 Selector_B : MUX_8_to_1
      Port Map (
        Sel => BSelect,                   
        I0 => t0,
        I1 => t1,  
        I2 => t2,
        I3 => t3,
        I4 => t4,
        I5 => t5, 
        I6 => t6,
        I7 => t7,
        O => BData
      );
      
Arithmetic_Unit : AU
     Port Map( 
              A => AData,
              B => BData,
            Sub => Sub_Sel,
              S => Operation_Result,
       Overflow => Overflow,
           Zero => Zero
       );
       
ProgramROM : Program_ROM
    Port Map(
          ROM_address => Current_Address,
                    I => Instruction
      );
 
R7  <= t7;
      
end Behavioral;
