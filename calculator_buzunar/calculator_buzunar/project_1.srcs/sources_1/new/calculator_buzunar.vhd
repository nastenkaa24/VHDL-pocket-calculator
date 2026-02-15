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

entity calculator_buzunar is
  Port ( clk: in std_logic;
         numar: in std_logic_vector(7 downto 0);
         operatie: in std_logic_vector(1 downto 0);
         mem_btn: in std_logic;
         reset_buton: in std_logic;
         
         an: out std_logic_vector(3 downto 0);
         cat: out std_logic_vector(6 downto 0));
end calculator_buzunar;

architecture Behavioral of calculator_buzunar is

component afisor
Port (
    clk     : in  std_logic;
    digit_0 : in  std_logic_vector(3 downto 0);
    digit_1 : in  std_logic_vector(3 downto 0);
    digit_2 : in  std_logic_vector(3 downto 0);
    digit_3 : in  std_logic_vector(3 downto 0);

    an      : out std_logic_vector(3 downto 0);
    cat     : out std_logic_vector(6 downto 0));
end component;

component debouncer
  Port (
    clk        : in  std_logic;
    btn        : in  std_logic;
    btn_pulse  : out std_logic);
end component;

component mux_4
Port ( 
    in_0: in  std_logic_vector(15 downto 0);
    in_1: in  std_logic_vector(15 downto 0);
    in_2: in  std_logic_vector(15 downto 0);
    in_3: in  std_logic_vector(15 downto 0);
    sel: in  std_logic_vector(1 downto 0);
    out_mux: out std_logic_vector(15 downto 0));
 end component;

component sumator_8bit
Port (
    A: in  std_logic_vector(7 downto 0);
    B: in  std_logic_vector(7 downto 0);
    Rezultat: out std_logic_vector(15 downto 0));
end component;

component scazator_8bit
Port (
    A: in  std_logic_vector(7 downto 0);
    B: in  std_logic_vector(7 downto 0);
    Rezultat: out std_logic_vector(15 downto 0));
end component;

component inmultitor_8bit
Port (
    clk: in  std_logic;
    A: in  std_logic_vector(7 downto 0);
    B: in  std_logic_vector(7 downto 0);
    Rezultat: out std_logic_vector(15 downto 0));
end component;

component impartitor_8bit
Port (
    A: in  std_logic_vector(7 downto 0);
    B: in  std_logic_vector(7 downto 0);
    Rezultat: out std_logic_vector(15 downto 0));
end component;


component registru_memorare
Port (
    clk: in std_logic;
    reset: in std_logic;
    pl: in std_logic;
    d_in: in std_logic_vector(7 downto 0);
    q_out: out std_logic_vector(7 downto 0));
end component;

component unitate_control
Port (
    clk: in std_logic;
    reset: in std_logic;
    mem_btn: in std_logic;
    
    load_A: out std_logic;
    load_B: out std_logic;
    sel_afis: out std_logic_vector(1 downto 0));
end component;

signal btn_pulse: std_logic := '0';
signal digit_0, digit_1, digit_2, digit_3: std_logic_vector(3 downto 0);

signal load_A, load_B: std_logic:= '0';
signal sel_afis:  std_logic_vector(1 downto 0);

signal numar_A: std_logic_vector(7 downto 0);
signal numar_B: std_logic_vector(7 downto 0);

signal afis_mux_0, afis_mux_1, afis_mux_2, afis_mux_3: std_logic_vector(15 downto 0);
signal op_mux_0, op_mux_1, op_mux_2, op_mux_3: std_logic_vector(15 downto 0);

signal op_rezultat: std_logic_vector(15 downto 0):=(others =>'0');
signal numar_afis: std_logic_vector(15 downto 0):=(others =>'0');

begin

u_debouncer: debouncer port map (
    clk=> clk,
    btn=> mem_btn,
    btn_pulse => btn_pulse);
    
u_unitate_control: unitate_control port map (
    clk=> clk,
    reset=> reset_buton,
    mem_btn=> btn_pulse,
    load_A=> load_A,
    load_B=> load_B,
    sel_afis=> sel_afis);
           
u_reg_A: registru_memorare port map (
    clk=> clk,
    reset=> reset_buton,
    pl=> load_A,
    d_in=>numar,
    q_out=>numar_A);
    
u_reg_B: registru_memorare port map (
    clk=> clk,
    reset=> reset_buton,
    pl=> load_B,
    d_in=> numar,
    q_out=> numar_B);
    
u_sumator: sumator_8bit port map (
    A=> numar_A,
    B=> numar_B,
    Rezultat=> op_mux_0);

u_scazator: scazator_8bit port map (
    A=> numar_A,
    B=> numar_B,
    Rezultat=> op_mux_1);
  
u_inmultitor: inmultitor_8bit port map (
    clk=> clk,
    A=> numar_A,
    B=> numar_B,
    Rezultat=> op_mux_2);  

u_impartitor: impartitor_8bit port map (
    A=> numar_A,
    B=> numar_B,
    Rezultat=> op_mux_3);

u_mux_op: mux_4 port map (
    in_0=> op_mux_0,
    in_1=> op_mux_1,
    in_2=> op_mux_2,
    in_3=> op_mux_3,
    sel=>operatie,
    out_mux=>op_rezultat);
  
afis_mux_0 <= x"A0" & std_logic_vector(signed(numar));
afis_mux_1 <= x"B0" & std_logic_vector(signed(numar));
afis_mux_2 <= op_rezultat;
afis_mux_3 <= (others => '0');  

u_mux_afisor: mux_4 port map (
    in_0=> afis_mux_0,
    in_1=> afis_mux_1,
    in_2=> afis_mux_2,
    in_3=> afis_mux_3,
    sel=>sel_afis,
    out_mux=>numar_afis);

u_afisor: afisor port map (
    clk=> clk,
    digit_0=> numar_afis(3 downto 0),
    digit_1=> numar_afis(7 downto 4),
    digit_2=> numar_afis(11 downto 8),
    digit_3=> numar_afis(15 downto 12),
    an=> an,
    cat=> cat);

end Behavioral;
