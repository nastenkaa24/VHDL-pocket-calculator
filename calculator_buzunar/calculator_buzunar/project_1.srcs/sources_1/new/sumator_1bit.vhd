library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumator_1bit is
 Port ( A: in std_logic;
        B: in std_logic;
        Cin: in std_logic;
        Cout: out std_logic;
        S : out std_logic);
end sumator_1bit;

architecture Behavioral of sumator_1bit is

begin
S<=A xor B xor Cin;
Cout<=(A and B) or (A and Cin) or (B and Cin);

end Behavioral;
