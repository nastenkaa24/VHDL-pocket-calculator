library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
 Port ( clk: in  std_logic;
        btn: in  std_logic;
        btn_pulse: out std_logic
       );
end debouncer;

architecture Behavioral of debouncer is

signal btn_prev:std_logic:='0';

begin

process(clk)
begin
    if rising_edge(clk) then
        if btn = '1' and btn_prev = '0' then
            btn_pulse <= '1';
        else
            btn_pulse <= '0';
        end if;
        btn_prev <= btn;
    end if;
end process;


end Behavioral;
