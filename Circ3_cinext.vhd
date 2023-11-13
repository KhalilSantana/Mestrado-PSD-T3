library ieee;
use ieee.std_logic_1164.all;

entity Circ3_cinext is
   port (
      i_Sel : in std_logic_vector(2 downto 0);
      o_Cin : out std_logic
   );
end entity;

architecture arch_1 of Circ3_cinext is

begin

   o_Cin <= '1' when (i_Sel = "001" or i_Sel = "010") else
      '0';

end architecture;