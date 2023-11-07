library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ2_toplevel is
   generic (
      p_WIDTH : integer := 16
   );
   port (
      i_C : in std_logic_vector(p_WIDTH - 1 downto 0);
      o_F : out std_logic_vector(p_WIDTH - 1 downto 0)
   );
end entity;
architecture arch_1 of Circ2_toplevel is
   signal w_SHL_6_out         : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_SHL_5_out         : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_SHL_2_out         : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_SHL_1_out         : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ADDER_TOP_LEFT    : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ADDER_TOP_RIGHT   : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ADDER_MIDDLE      : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ADDER_BOTTOM      : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ADDER_BOTTOM_LEFT : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_SHR_7_out         : std_logic_vector(p_WIDTH - 1 downto 0);
   component Circ2_n_shifter is
      generic (
         p_WIDTH : integer := 8
      );
      port (
         i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_N   : in std_logic_vector(3 downto 0);
         i_DIR : in std_logic;
         o_OUT : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_SHL_6 : Circ2_n_shifter generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_A => i_C,
      -----------5421
      i_N   => b"0110",
      i_DIR => '0',
      o_OUT => w_SHL_6_out
   );
   u_SHL_5 : Circ2_n_shifter generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_A => i_C,
      -----------5421
      i_N   => b"1000",
      i_DIR => '0',
      o_OUT => w_SHL_5_out
   );
   --
   u_SHL_2 : Circ2_n_shifter generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_A => i_C,
      -----------5421
      i_N   => b"0010",
      i_DIR => '0',
      o_OUT => w_SHL_2_out
   );
   u_SHL_1 : Circ2_n_shifter generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_A => i_C,
      -----------5421
      i_N   => b"0001",
      i_DIR => '0',
      o_OUT => w_SHL_1_out
   );
   w_ADDER_TOP_LEFT  <= std_logic_vector(unsigned(w_SHL_5_out) + unsigned(w_SHL_6_out));
   w_ADDER_TOP_RIGHT <= std_logic_vector(unsigned(w_SHL_2_out) + unsigned(w_SHL_1_out));
   w_ADDER_MIDDLE    <= std_logic_vector(unsigned(w_ADDER_TOP_LEFT) + unsigned(w_ADDER_TOP_RIGHT));

   u_SHR_7 : Circ2_n_shifter generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_A => w_ADDER_MIDDLE,
      -----------5421
      i_N   => b"1010",
      i_DIR => '1',
      o_OUT => w_SHR_7_out
   );
   w_ADDER_BOTTOM_LEFT <= std_logic_vector(unsigned(i_C) + unsigned(w_SHR_7_out));
   w_ADDER_BOTTOM      <= std_logic_vector(unsigned(w_ADDER_BOTTOM_LEFT) + 32); -- TODO Figure out why this is 33 not 32
   o_F                 <= w_ADDER_BOTTOM;
end architecture;