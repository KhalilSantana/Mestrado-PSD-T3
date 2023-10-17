library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ1_rgb_to_cmy_tb is
end entity;
architecture arch_1 of Circ1_rgb_to_cmy_tb is
   signal w_R, w_G, w_B : std_logic_vector(7 downto 0);
   signal w_C, w_M, w_Y : std_logic_vector(7 downto 0);

   component Circ1_rgb_to_cmy is
      generic (
         p_WIDTH : integer := 8
      );
      port (
         i_R : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_G : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_B : in std_logic_vector(p_WIDTH - 1 downto 0);
         --
         o_C : out std_logic_vector(p_WIDTH - 1 downto 0);
         o_M : out std_logic_vector(p_WIDTH - 1 downto 0);
         o_Y : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_rgb_cmy : Circ1_rgb_to_cmy port map(
      i_R => w_R,
      i_G => w_G,
      i_B => w_B,
      --
      o_C => w_C,
      o_M => w_M,
      o_Y => w_Y
   );
   process
   begin
      w_R <= x"EE";
      w_G <= x"00";
      w_B <= x"00";
      wait for 1 ps;
      wait;
   end process;
end architecture;