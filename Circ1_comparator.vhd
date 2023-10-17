library ieee;
use ieee.std_logic_1164.all;
entity Circ1_comparator is
   port (
      i_A      : in std_logic;
      i_B      : in std_logic;
      i_A_GT_B : in std_logic := '0';
      i_EQUAL  : in std_logic := '1';
      i_A_LT_B : in std_logic := '0';
      -- Outputs
      o_A_GT_B : out std_logic;
      o_EQUAL  : out std_logic;
      o_A_LT_B : out std_logic
   );
end entity;
architecture arch_1 of Circ1_comparator is

begin
   -- Digital Design pg 211
   o_A_GT_B <= i_A_GT_B or (i_EQUAL and i_A and not(i_B));
   o_EQUAL  <= i_EQUAL and (i_A xnor i_B);
   o_A_LT_B <= i_A_LT_B or (i_EQUAL and not(i_A) and i_B);
end architecture;