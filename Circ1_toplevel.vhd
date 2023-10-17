library ieee;
use ieee.std_logic_1164.all;
entity Circ1_toplevel is
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
end entity;
architecture arch_1 of Circ1_toplevel is
   signal w_C, w_M, w_Y, w_K      : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_Min_top, w_Min_middle : std_logic_vector(p_WIDTH - 1 downto 0);
   component Circ1_subtract is
      generic (
         p_WIDTH : integer := 8
      );
      port (
         i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_B   : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_OUT : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
   component Circ1_minfinder is
      generic (
         p_WIDTH : integer := 8
      );
      port (
         i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_B   : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_MIN : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
   component Circ1_rgb_to_cmy is
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
         o_Y : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Circ1_rgb_to_cmy : Circ1_rgb_to_cmy port map(
      i_R => i_R,
      i_G => i_G,
      i_B => i_B,
      --
      o_C => w_C,
      o_M => w_M,
      o_Y => w_Y
   );
   u_Min_top : Circ1_minfinder port map(
      i_B   => w_C,
      i_A   => w_M,
      o_MIN => w_Min_top
   );
   u_Min_middle : Circ1_minfinder port map(
      i_B   => w_Min_top,
      i_A   => w_Y,
      o_MIN => w_Min_middle
   );
   u_Sub_left : Circ1_subtract port map(
      i_A   => w_C,
      i_B   => w_Min_middle,
      o_OUT => o_C
   );
   u_Sub_middle : Circ1_subtract port map(
      i_A   => w_M,
      i_B   => w_Min_middle,
      o_OUT => o_M
   );
   u_Sub_right : Circ1_subtract port map(
      i_A   => w_Y,
      i_B   => w_Min_middle,
      o_OUT => o_Y
   );
   o_K <= w_Min_middle;
end architecture;