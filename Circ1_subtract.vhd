library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ1_subtract is
   generic (
      p_WIDTH : integer := 8
   );
   port (
      i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
      i_B   : in std_logic_vector(p_WIDTH - 1 downto 0);
      o_OUT : out std_logic_vector(p_WIDTH - 1 downto 0)
   );
end entity;
architecture arch_1 of Circ1_subtract is
begin
   o_OUT <= std_logic_vector(unsigned(i_A) - unsigned(i_B));
end architecture;