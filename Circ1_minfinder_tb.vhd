library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Circ1_minfinder_tb is
   generic (
      p_WIDTH : integer := 8
   );
end Circ1_minfinder_tb;
architecture arch_1 of Circ1_minfinder_tb is
   signal w_A            : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '0');
   signal w_B            : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '0');
   signal w_MIN          : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_DEBUG_A_GT_B : std_logic_vector(p_WIDTH downto 0);
   signal w_DEBUG_A_EQ_B : std_logic_vector(p_WIDTH downto 0);
   signal w_DEBUG_A_LT_B : std_logic_vector(p_WIDTH downto 0);
   component Circ1_minfinder is
      generic (
         p_WIDTH : integer := 8
      );
      port (
         i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_B   : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_MIN : out std_logic_vector(p_WIDTH - 1 downto 0)
         ;
         o_DEBUG_A_GT_B : out std_logic_vector(p_WIDTH downto 0)
         ;
         o_DEBUG_A_EQ_B : out std_logic_vector(p_WIDTH downto 0)
         ;
         o_DEBUG_A_LT_B : out std_logic_vector(p_WIDTH downto 0)
      );
   end component;
begin
   u_Circ1_minfinder : Circ1_minfinder
   generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_A              => w_A,
      i_B              => w_B,
      o_MIN            => w_MIN
      , o_DEBUG_A_GT_B => w_DEBUG_A_GT_B
      , o_DEBUG_A_EQ_B => w_DEBUG_A_EQ_B
      , o_DEBUG_A_LT_B => w_DEBUG_A_LT_B
   );
   process
   begin
      w_A <= std_logic_vector(to_unsigned(0, w_MIN'length));
      w_B <= std_logic_vector(to_unsigned(0, w_MIN'length));
      wait for 1 ps;
      assert w_MIN = std_logic_vector(to_unsigned(0, w_A'length)) report "A:0, B:0 -> 0" severity error;

      w_A <= std_logic_vector(to_unsigned(1, w_MIN'length));
      w_B <= std_logic_vector(to_unsigned(1, w_MIN'length));
      wait for 1 ps;
      assert w_MIN = std_logic_vector(to_unsigned(1, w_MIN'length)) report "A:1, B:1 -> 1" severity error;

      w_A <= std_logic_vector(to_unsigned(0, w_MIN'length));
      w_B <= std_logic_vector(to_unsigned(1, w_MIN'length));
      wait for 1 ps;
      assert w_MIN = std_logic_vector(to_unsigned(0, w_MIN'length)) report "A:0, B:1 -> 0" severity error;

      w_A <= std_logic_vector(to_unsigned(8, w_MIN'length));
      w_B <= std_logic_vector(to_unsigned(7, w_MIN'length));
      wait for 1 ps;
      assert w_MIN = std_logic_vector(to_unsigned(7, w_MIN'length)) report "A:8, B:7 -> 7" severity error;
      w_A <= std_logic_vector(to_unsigned(7, w_MIN'length));
      w_B <= std_logic_vector(to_unsigned(8, w_MIN'length));
      wait for 1 ps;
      assert w_MIN = std_logic_vector(to_unsigned(7, w_MIN'length)) report "A:7, B:8 -> 7" severity error;

      w_A <= std_logic_vector(to_unsigned(254, w_MIN'length));
      w_B <= std_logic_vector(to_unsigned(240, w_MIN'length));
      wait for 1 ps;
      assert w_MIN = std_logic_vector(to_unsigned(240, w_MIN'length)) report "A:254, B:240 -> 240" severity error;

      wait;
   end process;
end architecture;