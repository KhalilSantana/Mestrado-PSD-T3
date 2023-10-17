library ieee;
use ieee.std_logic_1164.all;
entity Circ1_minfinder is
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
end entity;
architecture arch_1 of Circ1_minfinder is
   signal w_LT      : std_logic_vector(p_WIDTH downto 0) := (others => '0');
   signal w_EQ      : std_logic_vector(p_WIDTH downto 0) := (others => '0');
   signal w_GT      : std_logic_vector(p_WIDTH downto 0) := (others => '0');
   signal w_MUX_SEL : std_logic_vector(2 downto 0);

   component Circ1_comparator is
      port (
         i_A      : in std_logic;
         i_B      : in std_logic;
         i_A_GT_B : in std_logic := '0';
         i_EQUAL  : in std_logic := '1';
         i_A_LT_B : in std_logic := '0';
         -- Outputs
         o_A_GT_B : out std_logic;
         o_EQUAL  : out std_logic;
         o_A_LT_B : out std_logic
      );
   end component;

begin
   w_EQ(p_WIDTH) <= '1';
   comparators :
   for n in p_WIDTH downto 1 generate
      comparator :
      Circ1_comparator
      port map(
         i_A      => i_A(n - 1),
         i_B      => i_B(n - 1),
         i_A_GT_B => w_GT(n),
         i_EQUAL  => w_EQ(n),
         i_A_LT_B => w_LT(n),
         -- Outputs
         o_A_GT_B => w_GT(n - 1),
         o_EQUAL  => w_EQ(n - 1),
         o_A_LT_B => w_LT(n - 1)
      );
   end generate;
   -- One hot encoding
   w_MUX_SEL <= w_GT(0) & w_EQ(0) & w_LT(0);

   o_DEBUG_A_GT_B <= w_GT;
   o_DEBUG_A_EQ_B <= w_EQ;
   o_DEBUG_A_LT_B <= w_LT;

   o_MUX : process (i_A, i_B, w_MUX_SEL)
   begin
      case w_MUX_SEL is
            ------GEL
            -- A>B
         when "100" =>
            o_MIN <= i_B;
            -- A=B
         when "010" =>
            o_MIN <= i_A;
            -- A<B
         when "001" =>
            o_MIN <= i_A;
         when others      =>
            o_MIN <= (others => '0'); -- Default case
      end case;
   end process;
end architecture;