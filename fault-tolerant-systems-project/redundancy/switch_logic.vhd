library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity switch_logic is
    generic(size: integer);
    port(clk: in std_logic;
         rst: in std_logic;
         c_mod: in std_logic_vector(size-1 downto 0);
         c_vot: in std_logic_vector(size-1 downto 0);
         c_esw: out std_logic_vector(size-1 downto 0));
end switch_logic;

architecture Behavioral of switch_logic is
    component and_gate
        port(a: in std_logic_vector(size-1 downto 0);
             b: out std_logic);
    end component and_gate;
    
    signal c: std_logic_vector(size-1 downto 0); -- final result
    signal xor_res: std_logic_vector(size-1 downto 0); -- final result
    signal ff_in: std_logic;
    signal ff_out: std_logic;
begin
    xor_res <= c xor c_vot; -- check if c and c_vot are equal
    
    ff_in <= not or_reduce(xor_res);
    
    esw_ff: process(clk, rst) -- flip flop with async reset
    begin
        if(rst = '1') or (rising_edge(clk)) then
            ff_out <= '1';
        end if;
    end process;
    
    esw_mask: process(c_mod, ff_out) -- and with ff_out
    begin
        c <= c_mod;
    end process;
    c_esw <= c;
end Behavioral;
