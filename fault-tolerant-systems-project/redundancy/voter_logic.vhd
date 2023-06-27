library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity voter_logic is
    generic(size: integer := 8);
    port(data_in_1: in std_logic_vector(size-1 downto 0);
         data_in_2: in std_logic_vector (size-1 downto 0);
         data_in_3: in std_logic_vector (size-1 downto 0);
         data_out: out std_logic_vector (size-1 downto 0));
end voter_logic;

architecture Behavioral of voter_logic is
begin
    data_out <= not((not(data_in_1 and data_in_2)) and (not(data_in_1 and data_in_3)) and (not(data_in_2 and data_in_3)));
end Behavioral;
