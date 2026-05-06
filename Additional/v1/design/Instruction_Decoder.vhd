library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 16-bit instruction format:
--   [15:13] opcode  (3 bits)
--   [12:9]  RegA    (4 bits)
--   [8:5]   RegB    (4 bits)
--   [4:0]   imm / jump-address (5 bits; MOVI uses [3:0])
--
-- Opcodes:
--   000 = ADD  Ra, Rb  →  Ra = Ra + Rb
--   001 = NEG  Ra      →  Ra = 0  - Ra
--   010 = MOVI Ra, imm →  Ra = imm
--   011 = JZR  Ra, addr→  if Ra==0 then PC = addr
--   100 = AND  Ra, Rb  →  Ra = Ra AND Rb
--   101 = OR   Ra, Rb  →  Ra = Ra OR  Rb
--   110 = NOT  Ra      →  Ra = NOT Ra
--   111 = NOP

entity Instruction_Decoder is
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
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
begin
    process(Instruction, JumpCheck)
    begin
        -- Safe defaults (prevent latches)
        RegEn       <= (others => '0');
        Sel_A       <= (others => '0');
        Sel_B       <= (others => '0');
        LoadSel     <= '0';
        ImmVal      <= (others => '0');
        Op          <= "000";
        JumpFlag    <= '0';
        JumpAddress <= (others => '0');

        case Instruction(15 downto 13) is

            when "000" =>  -- ADD Ra, Rb
                RegEn <= Instruction(12 downto 9);
                Sel_A <= Instruction(12 downto 9);
                Sel_B <= Instruction(8  downto 5);
                Op    <= "000";

            when "001" =>  -- NEG Ra  (= 0 - Ra, R0 is hardwired 0)
                RegEn <= Instruction(12 downto 9);
                Sel_A <= "0000";                       -- R0 = 0
                Sel_B <= Instruction(12 downto 9);
                Op    <= "001";

            when "010" =>  -- MOVI Ra, imm
                RegEn   <= Instruction(12 downto 9);
                LoadSel <= '1';
                ImmVal  <= Instruction(3 downto 0);

            when "011" =>  -- JZR Ra, addr
                Sel_A       <= Instruction(12 downto 9);
                JumpAddress <= Instruction(4 downto 0);
                if JumpCheck = "0000" then
                    JumpFlag <= '1';
                end if;

            when "100" =>  -- AND Ra, Rb
                RegEn <= Instruction(12 downto 9);
                Sel_A <= Instruction(12 downto 9);
                Sel_B <= Instruction(8  downto 5);
                Op    <= "010";

            when "101" =>  -- OR Ra, Rb
                RegEn <= Instruction(12 downto 9);
                Sel_A <= Instruction(12 downto 9);
                Sel_B <= Instruction(8  downto 5);
                Op    <= "011";

            when "110" =>  -- NOT Ra
                RegEn <= Instruction(12 downto 9);
                Sel_A <= Instruction(12 downto 9);
                Op    <= "100";

            when others => null;  -- NOP / reserved

        end case;
    end process;
end Behavioral;