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

entity inmultitor_8bit is
    Port (
        clk: in  std_logic;
        A: in  std_logic_vector(7 downto 0);
        B: in  std_logic_vector(7 downto 0);
        Rezultat: out std_logic_vector(15 downto 0));
end inmultitor_8bit;

architecture Behavioral of inmultitor_8bit is
signal multiplicand: signed(15 downto 0);
signal multiplier: signed(7 downto 0);
signal product: signed(15 downto 0);
signal i: integer range 0 to 7;
begin

process(clk)
variable temp_product : signed(15 downto 0);
begin
    if rising_edge(clk) then
        multiplicand <= resize(signed(A), 16);
        multiplier   <= signed(B);
        temp_product := (others => '0');
        
        for i in 0 to 7 loop
            if multiplier(i) = '1' then
                temp_product := temp_product + shift_left(multiplicand, i);
            end if;
        end loop;

        -- setare semn
        if (A(7) xor B(7)) = '1' then
            product <= -temp_product;
        else
            product <= temp_product;
        end if;
    end if;
end process;
Rezultat <= std_logic_vector(product);
end Behavioral;