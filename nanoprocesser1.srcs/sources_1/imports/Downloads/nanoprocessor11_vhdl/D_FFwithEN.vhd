library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FFwithEN is
    Port ( D : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           EN : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end D_FFwithEN;

architecture Behavioral of D_FFwithEN is
    signal q_reg : STD_LOGIC := '0';
begin

    process (Clk)
    begin
        if rising_edge(Clk) then
            if Res = '1' then
                q_reg <= '0';
            elsif EN = '1' then
                q_reg <= D;
            end if;
        end if;
    end process;

    Q <= q_reg;
    Qbar <= not q_reg;

end Behavioral;
