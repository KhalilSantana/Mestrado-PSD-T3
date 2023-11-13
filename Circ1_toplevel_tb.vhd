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

    -- rgb=(254, 0, 0)
    w_R <= x"FF";
    w_G <= x"00";
    w_B <= x"00";
    wait for 1 ps;
    assert (w_C = x"00" and w_M = x"FF" and w_Y = x"FF" and w_K = x"00")
    report "rgb=(255,0,0) != CMYK=(0,100,100,0)"
      severity error;

    -- rgb=(64, 30, 35)
    w_R <= x"40";
    w_G <= x"1E";
    w_B <= x"23";
    wait for 1 ps;
    assert (w_C = x"00" and w_M = x"22" and w_Y = x"1D" and w_K = x"BF")
    report "rgb=(64,30,35) != CMYK=(0,34,29,191)"
      severity error;

    -- rgb=(200, 200, 250)
    w_R <= x"C8";
    w_G <= x"C8";
    w_B <= x"FA";
    wait for 1 ps;
    assert (w_C = x"32" and w_M = x"32" and w_Y = x"00" and w_K = x"05")
    report "rgb=(64,30,35) != CMYK=(50,50,0,5)"
      severity error;

    -- rgb=(95, 110, 45)
    w_R <= x"5F";
    w_G <= x"6E";
    w_B <= x"2D";
    wait for 1 ps;
    assert (w_C = x"0F" and w_M = x"00" and w_Y = x"41" and w_K = x"91")
    report "rgb=(64,30,35) != CMYK=(,,,)"
      severity error;
    wait;
  end process;
end architecture;