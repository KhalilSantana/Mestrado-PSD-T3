library ieee;
use ieee.std_logic_1164.all;
entity Circ1_toplevel_tb is
end entity;
architecture arch_1 of Circ1_toplevel_tb is
   signal w_R, w_G, w_B      : std_logic_vector(7 downto 0) := (others => '0');
   signal w_C, w_M, w_Y, w_K : std_logic_vector(7 downto 0);
   component Circ1_toplevel is
      generic (
         p_WIDTH : integer := 8
      );
      port (
         i_R : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_G : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_B : in std_logic_vector(p_WIDTH - 1 downto 0);
         -- Outputs
         o_C : out std_logic_vector(p_WIDTH - 1 downto 0);
         o_M : out std_logic_vector(p_WIDTH - 1 downto 0);
         o_Y : out std_logic_vector(p_WIDTH - 1 downto 0);
         o_K : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_rgb_CMYK_Converter : Circ1_toplevel port map(
      i_R => w_R,
      i_G => w_G,
      i_B => w_B,
      --
      o_C => w_C,
      o_M => w_M,
      o_Y => w_Y,
      o_K => w_K
   );
   process
   begin
      wait for 1 ps;
      assert (w_C = x"00" and w_M = x"00" and w_Y = x"00" and w_K = x"FF")
      report "rgb=(0,0,0) != CMYK=(0,0,0,0)"
         severity error;
      w_R <= x"FF"; -- rgb(254, 0, 0)
      w_G <= x"00"; -- rgb(254, 0, 0)
      w_B <= x"00"; -- rgb(254, 0, 0)
      wait for 1 ps;
      assert (w_C = x"00" and w_M = x"FF" and w_Y = x"FF" and w_K = x"00") -- cmyk(0,100,100,0)
      report "rgb=(254,0,0) != CMYK=(0,100,100,0)"
         severity error;
      wait;
   end process;
end architecture;