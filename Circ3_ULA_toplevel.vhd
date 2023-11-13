library ieee;
use ieee.std_logic_1164.all;

entity Circ3_ULA_toplevel is
  port
  (
    i_A   : in std_logic_vector(7 downto 0);
    i_B   : in std_logic_vector(7 downto 0);
    i_Sel : in std_logic_vector(2 downto 0);
    o_S   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture arch_1 of Circ3_ULA_toplevel is
  signal w_A_ext : std_logic_vector(7 downto 0);
  signal w_B_ext : std_logic_vector(7 downto 0);
  signal w_A_add : std_logic_vector(7 downto 0);
  signal w_B_add : std_logic_vector(7 downto 0);
  signal w_Cin   : std_logic;
  signal w_Cout  : std_logic;
  component Circ3_8bit_adder is
    port
    (
      i_A     : in std_logic_vector(7 downto 0);
      i_B     : in std_logic_vector(7 downto 0);
      i_C_IN  : in std_logic;
      o_S     : out std_logic_vector(7 downto 0);
      o_C_OUT : out std_logic
    );
  end component;

  component Circ3_AL_extender is
    port
    (
      i_A   : in std_logic_vector(7 downto 0);
      i_B   : in std_logic_vector(7 downto 0);
      i_Sel : in std_logic_vector(2 downto 0);
      o_A   : out std_logic_vector(7 downto 0);
      o_B   : out std_logic_vector(7 downto 0);
      o_Cin : out std_logic
    );
  end component;

begin

  w_A_ext <= i_A;
  w_B_ext <= i_B;

  ext : Circ3_AL_extender
  port map
  (
    i_A   => w_A_ext,
    i_B   => w_B_ext,
    i_Sel => i_Sel,
    o_A   => w_A_add,
    o_B   => w_B_add,
    o_Cin => w_Cin
  );

  add : Circ3_8bit_adder
  port map(
  i_A     => w_A_add,
  i_B     => w_B_add,
  i_C_IN  => w_Cin,
  o_S     => o_S,
  o_C_OUT => w_Cout
  );

end architecture;