library ieee;
use ieee.std_logic_1164.all;

entity Circ3_calculator_toplevel is
   port (
      i_A   : in std_logic_vector(7 downto 0);
      i_B   : in std_logic_vector(7 downto 0);
      i_Sel : in std_logic_vector(2 downto 0);
      i_En  : in std_logic;
      i_Clk : in std_logic;
      o_S   : out std_logic_vector(7 downto 0)
   );
end entity;

architecture arch_1 of Circ3_calculator_toplevel is

   signal w_A_reg : std_logic_vector(7 downto 0);

   component Circ3_ULA_toplevel is
      port (
         i_A   : in std_logic_vector(7 downto 0);
         i_B   : in std_logic_vector(7 downto 0);
         i_Sel : in std_logic_vector(2 downto 0);
         o_S   : out std_logic_vector(7 downto 0)
      );
   end component;

   component Circ3_register is
      port (
         i_A   : in std_logic_vector(7 downto 0);
         i_En  : in std_logic;
         o_S   : out std_logic_vector(7 downto 0);
         i_Clk : in std_logic
      );
   end component;

begin

   ula : Circ3_ULA_toplevel
   port map
   (
      i_A   => i_A,
      i_B   => i_B,
      i_Sel => i_Sel,
      o_S   => w_A_reg
   );

   reg : Circ3_register
   port map(
      i_A   => w_A_reg,
      i_En  => i_En,
      o_S   => o_S,
      i_Clk => i_Clk
   );

end architecture;