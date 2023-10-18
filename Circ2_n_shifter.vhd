library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ2_n_shifter is
   generic (
      p_WIDTH : integer := 8
   );
   port (
      i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
      i_N   : in std_logic_vector(3 downto 0);
      i_DIR : in std_logic;
      o_OUT : out std_logic_vector(p_WIDTH - 1 downto 0)
   );
end entity;
architecture arch_1 of Circ2_n_shifter is
   signal w_ONE, w_TWO, w_THREE : std_logic_vector(p_WIDTH - 1 downto 0);
begin
   process (i_A, i_N, i_DIR, w_ONE, w_TWO, w_THREE)
   begin
      -- TODO: use for generate here
      -- First stage
      if i_N(0) = '1' and i_DIR = '0' then
         w_ONE <= std_logic_vector(shift_left(unsigned(i_A), 1));
      elsif i_N(0) = '1' and i_DIR = '1' then
         w_ONE <= std_logic_vector(shift_right(unsigned(i_A), 1));
      else
         w_ONE <= i_A;
      end if;
      -- Second Stage
      if i_N(1) = '1' and i_DIR = '0' then
         w_TWO <= std_logic_vector(shift_left(unsigned(w_ONE), 2));
      elsif i_N(1) = '1' and i_DIR = '1' then
         w_TWO <= std_logic_vector(shift_right(unsigned(w_ONE), 2));
      else
         w_TWO <= w_ONE;
      end if;
      -- Third Stage
      if i_N(2) = '1' and i_DIR = '0' then
         w_THREE <= std_logic_vector(shift_left(unsigned(w_TWO), 4));
      elsif i_N(2) = '1' and i_DIR = '1' then
         w_THREE <= std_logic_vector(shift_right(unsigned(w_TWO), 4));
      else
         w_THREE <= w_TWO;
      end if;
      -- Forth Stage
      if i_N(3) = '1' and i_DIR = '0' then
         o_OUT <= std_logic_vector(shift_left(unsigned(w_THREE), 5));
      elsif i_N(3) = '1' and i_DIR = '1' then
         o_OUT <= std_logic_vector(shift_right(unsigned(w_THREE), 5));
      else
         o_OUT <= w_THREE;
      end if;
   end process;
end architecture;