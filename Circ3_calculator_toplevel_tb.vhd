library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Circ3_calculator_toplevel_tb is
end entity;

architecture tb of Circ3_calculator_toplevel_tb is

   component Circ3_calculator_toplevel
      port (
         i_A   : in std_logic_vector(7 downto 0);
         i_B   : in std_logic_vector(7 downto 0);
         i_Sel : in std_logic_vector(2 downto 0);
         i_En  : in std_logic;
         i_Clk : in std_logic;
         o_S   : out std_logic_vector(7 downto 0)
      );
   end component;

   signal w_A   : std_logic_vector(7 downto 0) := "00001111";
   signal w_B   : std_logic_vector(7 downto 0) := "00000101";
   signal w_Sel : std_logic_vector(2 downto 0) := "000";
   signal w_En  : std_logic                    := '1';
   signal w_Clk : std_logic                    := '1';
   signal w_S   : std_logic_vector(7 downto 0) := "00000000";

begin

   u_calculator : Circ3_calculator_toplevel

   port map
   (
      i_A   => w_A,
      i_B   => w_B,
      i_Sel => w_Sel,
      i_En  => w_En,
      i_Clk => w_Clk,
      o_S   => w_S
   );

   process (w_ClK)
   begin
      w_ClK <= not w_ClK after 1 ps;
   end process;

   process
   begin

      w_Sel <= "000"; --soma
      wait for 10 ps;
      assert(w_S = "00010100") report "Soma incorreta" severity error;

      w_Sel <= "001"; -- sub
      wait for 10 ps;
      assert(w_S = "00001010") report "Subtracao incorreta" severity error;

      w_Sel <= "010"; -- soma 1
      wait for 10 ps;
      assert(w_S = "00010000") report "soma 1 incorreto" severity error;

      w_Sel <= "011"; -- mantem A
      wait for 10 ps;
      assert(w_S = "00001111") report "mantem A incorreto" severity error;

      w_Sel <= "100"; -- and 
      wait for 10 ps;
      assert(w_S = "00000101") report "AND incorreto" severity error;

      w_Sel <= "101"; -- or
      wait for 10 ps;
      assert(w_S = "00001111") report "OR incorreto" severity error;

      w_Sel <= "110"; -- xor
      wait for 10 ps;
      assert(w_S = "00001010") report "XOR incorreto" severity error;

      w_Sel <= "111"; -- not A
      wait for 10 ps;
      assert(w_S = "11110000") report "Not incorreto" severity error;

      wait;
   end process;

end architecture;