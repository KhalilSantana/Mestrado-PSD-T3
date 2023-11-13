library ieee;
use ieee.std_logic_1164.all;

entity Circ3_AL_extender is
  port
  (
    i_A   : in std_logic_vector(7 downto 0);
    i_B   : in std_logic_vector(7 downto 0);
    i_Sel : in std_logic_vector(2 downto 0);
    o_A   : out std_logic_vector(7 downto 0);
    o_B   : out std_logic_vector(7 downto 0);
    o_Cin : out std_logic
  );
end entity;

architecture arch_1 of Circ3_AL_extender is
  signal w_A : std_logic_vector(7 downto 0);
  signal w_B : std_logic_vector(7 downto 0);
  component Circ3_abext is
    port
    (
      i_A   : in std_logic;
      i_B   : in std_logic;
      i_Sel : in std_logic_vector(2 downto 0);
      o_A   : out std_logic;
      o_B   : out std_logic
    );
  end component;

  component Circ3_cinext is
    port
    (
      i_Sel : in std_logic_vector(2 downto 0);
      o_Cin : out std_logic
    );
  end component;

begin

  cinext : Circ3_cinext
  port map
  (
    i_Sel => i_Sel,
    o_Cin => o_Cin
  );

  abexts : for n in 0 to 7 generate
    abext : Circ3_abext
    port map (
    i_A   => i_A(n),
    i_B   => i_B(n),
    i_Sel => i_Sel,
    o_A   => w_A(n),
    o_B   => w_B(n)
    );
  end generate;

  o_A <= w_A;
  o_B <= w_B;

end architecture;