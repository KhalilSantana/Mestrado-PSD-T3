library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ2_toplevel_tb is
   generic (
      p_WIDTH : integer := 16
   );
end entity;
architecture arch_1 of Circ2_toplevel_tb is
   signal w_C, w_F : std_logic_vector(p_WIDTH - 1 downto 0);
   component Circ2_toplevel is
      generic (
         p_WIDTH : integer := 16
      );
      port (
         i_C : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_F : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Circ2_toplevel : Circ2_toplevel generic map(
      p_WIDTH => p_WIDTH
   )
   port map(
      i_C => w_C,
      o_F => w_F
   );
   process
   begin
      w_C <= std_logic_vector(to_unsigned(0, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(32, w_F'length));
         report "0 C != 32 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(5, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(41, w_F'length));
         report "5 C != 41 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(10, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(50, w_F'length));
         report "10 C != 50 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(15, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(59, w_F'length));
         report "15 C != 59 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(21, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(69, w_F'length));
         report "21 C != 69 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(25, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(77, w_F'length));
         report "25 C != 77 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(30, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(86, w_F'length));
         report "30 C != 86 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(45, w_F'length));
      wait for 1 ps;
      assert to_string(unsigned(w_F)) = to_string(to_unsigned(113, w_F'length));
         report "45 C != 113 F"
         severity error;

      w_C <= std_logic_vector(to_unsigned(99, w_C'length));
      report "w_F = " & to_string(unsigned(w_F)) severity note;
      wait for 10 ps;
      -- report "w_F = " & unsigned(w_F) severity note;
      assert unsigned(w_F) = to_unsigned(210, w_F'length);
         report "99 C != 210 F"
         severity error;

      wait for 1 ps;

      w_C <= std_logic_vector(to_unsigned(100, w_C'length));
      wait for 1 ps;
      assert unsigned(w_F) = to_string(to_unsigned(212, w_F'length))
      report "100 C != 212 F"
      severity error;

      wait;
   end process;
end architecture;