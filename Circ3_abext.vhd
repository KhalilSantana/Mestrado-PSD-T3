library ieee;
use ieee.std_logic_1164.all;

entity Circ3_abext is
   port (
      i_A   : in std_logic;
      i_B   : in std_logic;
      i_Sel : in std_logic_vector(2 downto 0);
      o_A   : out std_logic;
      o_B   : out std_logic
   );
end entity;

architecture arch_1 of Circ3_abext is
begin

   o_A <= i_A and   i_B when (i_Sel = "100") else
          i_A or    i_B when (i_Sel = "101") else
          i_A xor   i_B when (i_Sel = "110") else
          not(i_A)      when (i_Sel = "111") else
          i_A;

   o_B <= i_B       when (i_Sel = "000") else
          not(i_B)  when (i_Sel = "001") else
          '0';

end architecture;