library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ2_toplevel_tb is
   generic (
      p_WIDTH : integer := 16
   );
end entity;
architecture arch_1 of Circ2_toplevel_tb is
   signal w_C, w_F : std_logic_vector(p_WIDTH - 1 downto 0);
   component Circ2_toplevel is
      generic (
         p_WIDTH : integer := 16
      );
      port (
         i_C : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_F : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Circ2_toplevel : Circ2_toplevel generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_C => w_C,
      o_F => w_F
   );
   process
   begin
      w_C <= std_logic_vector(to_unsigned(30, w_C'length));
      wait;
   end process;
end architecture;