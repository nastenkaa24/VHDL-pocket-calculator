library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_4 is
 Port ( 
        in_0     : in  std_logic_vector(15 downto 0);
        in_1     : in  std_logic_vector(15 downto 0);
        in_2     : in  std_logic_vector(15 downto 0);
        in_3     : in  std_logic_vector(15 downto 0);
        sel     : in  std_logic_vector(1 downto 0);
        out_mux : out std_logic_vector(15 downto 0)
      );
 end mux_4;

architecture Behavioral of mux_4 is

begin
process(in_0, in_1, in_2, in_3, sel)
begin
    case sel is
      when "00" => out_mux <= in_0;
      when "01" => out_mux <= in_1;
      when "10" => out_mux <= in_2;
      when "11" => out_mux <= in_3;
      when others => out_mux <= (others => '0');
    end case;
end process;

end Behavioral;
