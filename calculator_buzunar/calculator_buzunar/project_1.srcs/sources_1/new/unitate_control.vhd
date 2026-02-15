library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity unitate_control is
  Port (
    clk: in std_logic;
    reset: in std_logic;
    mem_btn: in std_logic;
    load_A: out std_logic;
    load_B: out std_logic;
    sel_afis: out std_logic_vector(1 downto 0)
  );
end unitate_control;

architecture Behavioral of unitate_control is
type state_type is (MEM_A, MEM_B, AFIS_REZ);
signal state, next_state: state_type;

begin

process(clk, reset)
begin
    if reset = '1' then
      state <= MEM_A;
    elsif rising_edge(clk) then
      state <= next_state;
    end if;
end process;

process(state, mem_btn)
begin
    load_A <= '0';
    load_B <= '0';
    next_state <= state;

    case state is
      when MEM_A =>
        sel_afis <= "00";
        if mem_btn = '1' then
          load_A <= '1';
          next_state <= MEM_B;
        end if;
    
      when MEM_B =>
        sel_afis <= "01";
        if mem_btn = '1' then
          load_B <= '1';
          next_state <= AFIS_REZ;
        end if;
    
      when AFIS_REZ =>
        sel_afis <= "10";
        if mem_btn = '1' then
          next_state <= MEM_A;
        end if;
    
    end case;
end process;

end Behavioral;


