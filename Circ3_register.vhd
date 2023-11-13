library ieee;
use ieee.std_logic_1164.all;

entity Circ3_register is
  port
  (
    i_A   : in std_logic_vector(7 downto 0);
    i_En  : in std_logic;
    o_S   : out std_logic_vector(7 downto 0);
    i_Clk : in std_logic
  );
end entity;

architecture arch_1 of Circ3_register is
  signal w_Reg : std_logic_vector(7 downto 0) := (others => '0');

begin
  process (i_Clk, i_En)
  begin

    if rising_edge(i_Clk) then
      if i_En = '1' then
        w_Reg <= i_A;
      end if;
    end if;
  end process;

  o_S <= w_Reg;

end architecture;