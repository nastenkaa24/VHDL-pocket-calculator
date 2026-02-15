library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scazator_8bit is
  Port (
    A: in  std_logic_vector(7 downto 0);
    B: in  std_logic_vector(7 downto 0);
    Rezultat: out std_logic_vector(15 downto 0)
  );
end scazator_8bit;

architecture Behavioral of scazator_8bit is
component sumator_1bit is
    port (
        A: in  std_logic;
        B: in  std_logic;
        Cin: in  std_logic;
        Cout: out std_logic;
        S: out std_logic);
end component;

signal OP1, OP2: signed(15 downto 0);
signal A_ext, B_ext: signed(15 downto 0);
signal carry_chain: std_logic_vector(16 downto 0);
signal rez_temp: std_logic_vector(15 downto 0);
signal OP2_neg: signed(15 downto 0);

begin
A_ext <= resize(signed(A), 16);
B_ext <= resize(signed(B), 16);

OP1   <= A_ext;
OP2   <= B_ext;
OP2_neg <= not OP2;

carry_chain(0) <= '1';

gen_sumatori: for i in 0 to 15 generate
    uu: sumator_1bit port map(
        A    => OP1(i),
        B    => OP2_neg(i),
        Cin  => carry_chain(i),
        Cout => carry_chain(i+1),
        S    => rez_temp(i) );
end generate;

Rezultat <= rez_temp;

end Behavioral;