library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registru_memorare is
 Port ( clk: in std_logic;
        reset: in std_logic;
        pl: in std_logic;
        d_in: in std_logic_vector(7 downto 0);
        q_out: out std_logic_vector(7 downto 0)
       );
end registru_memorare;

architecture Behavioral of registru_memorare is

signal temp: std_logic_vector(7 downto 0);

begin

mem: process(clk) 
begin
    if reset = '1' then
        temp<= "00000000";
    elsif rising_edge(clk) then
        if pl = '1' then
            temp<= d_in;
        end if;
    end if;

q_out<= temp;
end process;

end Behavioral;
