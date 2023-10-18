library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ2_n_shifter_tb is
   generic (
      p_WIDTH : integer := 8
   );
end entity;
architecture arch_1 of Circ2_n_shifter_tb is
   signal w_A, w_OUT : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '0');
   signal w_N        : std_logic_vector(3 downto 0)           := b"0000";
   signal w_DIR      : std_logic                              := '0';
   component Circ2_n_shifter is
      port (
         i_A   : in std_logic_vector(p_WIDTH - 1 downto 0);
         i_N   : in std_logic_vector(3 downto 0);
         i_DIR : in std_logic;
         o_OUT : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Shifter : Circ2_n_shifter
   port map(
      i_A   => w_A,
      i_N   => w_N,
      i_DIR => w_DIR,
      o_OUT => w_OUT
   );
   process
   begin
      w_A   <= std_logic_vector(to_unsigned(2, w_A'length));
      w_N   <= b"0000";
      w_DIR <= '0';
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(2, w_A'length))
      report "2 << 0 != 2"
         severity error;

      w_N <= b"0001";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(4, w_A'length))
      report "2 << 1 != 4"
         severity error;

      w_N <= b"0010";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(8, w_A'length))
      report "2 << 2 != 8"
         severity error;

      w_N <= b"0011";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(16, w_A'length))
      report "2 << 3 != 16"
         severity error;

      w_N <= b"0100";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(32, w_A'length))
      report "2 << 4 != 32"
         severity error;

      w_N <= b"1000";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(64, w_A'length))
      report "2 << 5 != 64"
         severity error;

      -- Right shift
      w_A   <= std_logic_vector(to_unsigned(255, w_A'length));
      w_N   <= b"0000";
      w_DIR <= '1';
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(255, w_A'length))
      report "255 >> 0 != 255"
         severity error;

      w_N <= b"0001";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(127, w_A'length))
      report "255 >> 1 != 127"
         severity error;

      w_N <= b"0010";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(63, w_A'length))
      report "255 >> 2 != 63"
         severity error;

      w_N <= b"0100";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(15, w_A'length))
      report "255 >> 4 != 15"
         severity error;

      w_N <= b"1000";
      wait for 1 ps;
      assert w_OUT = std_logic_vector(to_unsigned(7, w_A'length))
      report "255 >> 5 != 7"
         severity error;
      wait;
   end process;
end architecture;