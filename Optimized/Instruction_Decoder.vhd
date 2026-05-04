library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Decoder is
    Port (
        Instruction : in  STD_LOGIC_VECTOR(11 downto 0);
        JumpCheck : in  STD_LOGIC_VECTOR(3 downto 0);
        RegEn : out STD_LOGIC_VECTOR(2 downto 0);
        Sel_A : out STD_LOGIC_VECTOR(2 downto 0);
        Sel_B : out STD_LOGIC_VECTOR(2 downto 0);
        LoadSel : out STD_LOGIC;
        ImmVal : out STD_LOGIC_VECTOR(3 downto 0);
        Sub : out STD_LOGIC;
        JumpFlag : out STD_LOGIC;
        JumpAddress : out STD_LOGIC_VECTOR(2 downto 0));
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
begin
    process(Instruction, JumpCheck)
    begin
        -- Defaults prevent latches
        RegEn <= (others => '0');
        Sel_A <= (others => '0');
        Sel_B <= (others => '0');
        LoadSel <= '0';
        ImmVal <= (others => '0');
        Sub <= '0';
        JumpFlag <= '0';
        JumpAddress <= (others => '0');

        case Instruction(11 downto 10) is
            when "00" =>  -- ADD: RegA = RegA + RegB
                RegEn <= Instruction(9 downto 7);
                Sel_A <= Instruction(9 downto 7);
                Sel_B <= Instruction(6 downto 4);

            when "01" =>  -- NEG: RegA = 0 - RegA (uses R0 as zero source)
                RegEn <= Instruction(9 downto 7);
                Sel_B <= Instruction(9 downto 7);
                Sub <= '1';

            when "10" =>  -- MOVI: RegA = immediate
                RegEn <= Instruction(9 downto 7);
                LoadSel <= '1';
                ImmVal <= Instruction(3 downto 0);

            when "11" =>  -- JZR: jump if register = 0
                Sel_A <= Instruction(9 downto 7);
                JumpAddress <= Instruction(2 downto 0);
                if JumpCheck = "0000" then
                    JumpFlag <= '1';
                end if;

            when others => null;
        end case;
    end process;
end Behavioral;
