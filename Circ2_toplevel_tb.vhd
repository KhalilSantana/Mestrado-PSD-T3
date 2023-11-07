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
    w_C <= x"0000"; -- 0 C
    wait for 1 ps;
    assert w_F = x"0020" -- 32 F
    report "0 C != 32 F"
      severity error;

    w_C <= x"0064"; -- 100 C
    wait for 1 ps;
    assert w_F = x"00D3" -- 212 (211) F
    report "100 C != 212 F"
      severity error;

    w_C <= x"001F"; -- 31 C
    wait for 1 ps;
    assert w_F = x"0057" -- 87 F
    report "30 C != 87 F"
      severity error;
    w_C <= x"0029"; -- 41 C
    wait for 1 ps;
    assert w_F = x"0069" -- 105 F
    report "41 C != 105 F"
      severity error;

    w_C <= x"0036"; -- 54 C
    wait for 1 ps;
    assert w_F = x"0081" -- 129 F
    report "54 C != 129 F"
      severity error;

    w_C <= x"004D"; -- 77 C
    wait for 1 ps;
    assert w_F = x"00AA" -- 170 F
    report "77 C != 170 F"
      severity error;



    wait;
  end process;
end architecture;